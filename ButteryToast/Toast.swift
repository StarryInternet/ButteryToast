//
//  Toast.swift
//  ButteryToast
//
//  Created by creisterer on 11/3/15.
//  Copyright © 2015 Starry. All rights reserved.
//

import UIKit

/**
 A toast contains a view for presentation by a Toaster.
 Toasts are unique - even two Toasts containing the same view are still different Toasts.
 This allows for managing toasts in a queue and determining if they have been presented yet.
 */

public class Toast: Operation {

  public enum Animation {
    /// - Default animation
    case fade
    /// - Slide animation works best with opaque views convering safe area inset
    case slide
  }
  
  var duration: TimeInterval
  var delay: TimeInterval
  var orientation: Orientation?
  let animation: Animation
  
  weak var toaster: Toaster?
  
  private let view: UIView
  private let transitionDuration: TimeInterval = 0.3
  private let onTap: ( (Toast) -> Void )?
  
  /**
   Initializes the `Toast` instance with the specified view.
   - parameter dismissAfter: If set, the time interval after which a Toast will auto-dismiss without user interaction. If unset, a Toast will persist until dismissed.
   - parameter height: If set, the height of the toast, enforced by AutoLayout. If unset, the height will be determined soley from the intrinsic content size of the view passed to the Toast.
   */
  public init(
    view: UIView,
    duration: TimeInterval = 2.0,
    delay: TimeInterval = 0.0,
    orientation: Orientation? = nil,
    animation: Animation = .fade,
    onTap: ( (Toast) -> Void )? = nil) {
    self.view = view
    self.duration = duration
    self.delay = delay
    self.orientation = orientation
    self.animation = animation
    self.onTap = onTap
  }
  
  private var _isExecuting = false
  override public var isExecuting: Bool {
    get {
      return _isExecuting
    }
    set {
      willChangeValue(forKey: "isExecuting")
      _isExecuting = newValue
      didChangeValue(forKey: "isExecuting")
    }
  }
  
  private var _isFinished = false
  override public var isFinished: Bool {
    get {
      return _isFinished
    }
    set {
      willChangeValue(forKey: "isFinished")
      _isFinished = newValue
      didChangeValue(forKey: "isFinished")
    }
  }
  
  private var isBeingManuallyDismissed = false
  
  override public func start() {
    guard !self.isExecuting else { return }
    super.start()
  }
  
  public override func cancel() {
    super.cancel()
    self.finish()
  }
  
  public override func main() {
    isExecuting = true
    doOperation()
  }
  
  private func doOperation() {
    guard Thread.isMainThread else {
      DispatchQueue.main.async {
        self.doOperation()
      }
      return
    }

    // find view to present in
    let topVC = self.toaster!.viewControllerToPresentIn()!
    topVC.view.addSubview(self.view)

    let yOffset: CGFloat

    switch resolvedOrientation {
    case .top:
      if #available(iOS 11.0, *) {
        yOffset = topVC.view.safeAreaInsets.top
      } else if topVC.navigationController != nil {
        yOffset = topVC.topLayoutGuide.length
      } else {
        yOffset = UIApplication.shared.statusBarFrame.size.height
      }
      self.view.topAnchor.constraint(equalTo: topVC.view.topAnchor, constant: yOffset).isActive = true
    case .bottom:
      if #available(iOS 11.0, *) {
        yOffset = -topVC.view.safeAreaInsets.bottom
      } else {
        yOffset = topVC.bottomLayoutGuide.length
      }
      self.view.bottomAnchor.constraint(equalTo: topVC.view.bottomAnchor, constant: yOffset).isActive = true
    }
    
    self.view.translatesAutoresizingMaskIntoConstraints = false
    self.view.leftAnchor.constraint(equalTo: topVC.view.leftAnchor).isActive = true
    self.view.rightAnchor.constraint(equalTo: topVC.view.rightAnchor).isActive = true
    self.view.heightAnchor.constraint(greaterThanOrEqualToConstant: self.view.bounds.height).isActive = true
    let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    self.view.addGestureRecognizer(tapGR)

    // animation setup

    let presentAnimations: () -> ()

    switch animation {
    case .fade:
      self.view.alpha = 0.0
      presentAnimations = { self.view.alpha = 1.0 }
    case .slide:
      presentAnimations = { self.view.transform = .identity }
    }

    // start in dismissed, or offscreen state
    self.view.layoutIfNeeded()
    dismissAnimations()

    UIView.animate(withDuration: self.transitionDuration, delay: self.delay, options: [.allowUserInteraction], animations: presentAnimations, completion: { animationsDidFinish in
      UIView.animate(withDuration: self.duration, delay: 0.0, options: [.allowUserInteraction], animations: {
        self.view.alpha = 1.0001
      }, completion: { animationsDidFinish in
        if animationsDidFinish {
          UIView.animate(withDuration: self.transitionDuration, animations: self.dismissAnimations, completion: { _ in
            self.finish()
          })
        } else if !self.isBeingManuallyDismissed {
          // ensure finish called if animation cancelled for some other reason
          self.finish()
        } else {
          // manual dismissal is handling dismis animation and calling finish
        }
      })
    })
  }
  
  private func finish() {
    if isFinished {
      return
    }
    self.view.removeFromSuperview()
    self.isExecuting = false
    self.isFinished = true
  }

  private var resolvedOrientation: Orientation {
    if let orientation = self.orientation ?? toaster?.orientation {
      return orientation
    } else {
      assertionFailure("no toaster found!"); return .top
    }
  }

  private func dismissAnimations() {
    switch animation {
    case .fade:
      view.alpha = 0.0
    case .slide:
      let offset: CGFloat
      switch resolvedOrientation {
      case .top: offset = -view.bounds.height
      case .bottom: offset = view.bounds.height
      }
      view.transform = CGAffineTransform.identity.translatedBy(x: 0, y: offset)
    }
  }
  
  @objc func handleTap(_ sender: UITapGestureRecognizer) {
    onTap?(self)
    isBeingManuallyDismissed = true
    UIView.animate(withDuration: self.transitionDuration, delay: 0.0, options: [.beginFromCurrentState], animations: dismissAnimations, completion: { _ in
      self.finish()
    })
  }
}

