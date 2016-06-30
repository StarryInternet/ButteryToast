//
//  Toaster.swift
//  ButteryToast
//
//  Created by creisterer on 11/3/15.
//  Copyright © 2015 Starry. All rights reserved.
//

import UIKit

/**
 Toaster manages a queue of Toasts and decides when they should be presented and dismissed.
 */
public class Toaster {
  public static let sharedInstance = Toaster()

  /**
   The view controller that toasts should be presented from.
   This can be changed if there are separate sections (such as w/ navigation controllers) of the app, such as modal view controller presentations.
   Alternatively, each section could have its own Toaster.
  */
  public weak var defaultViewController: UIViewController? = nil {
    didSet {
      canOverrideActive = true
    }
  }

  // get view controller
  private func viewControllerToPresentIn() -> UIViewController? {
    if let defaultViewController = defaultViewController {
      return defaultViewController
    } else {
      return UIApplication.sharedApplication().keyWindow?.rootViewController
    }
  }

  // if default view controller changes, active message may be allowed to be replaced, in case
  // active message is no longer visible.
  private var canOverrideActive = false

  private(set) var messageStack: [Toast] = []

  /**
   Prepare a Toast to be presented to the user.
   - parameter toast: The toast, encapsulating a view
   - parameter priority: Low appends to bottom of stack, High appends to top, Immediate is presented even if another Toast on screen.
  */
  public func prepareToast(toast: Toast, withPriority priority: ToastPriority = ToastPriority.Low) {
    toast.delegate = self
    // decide where to put message in stack
    switch priority {
    case .High, .Immediate:
      messageStack.append(toast)
    case .Low:
      messageStack.insert(toast, atIndex: 0)
    }
    if priority == .Immediate {
      dismissActiveMessage()  // dismissing message will also present next in line
    } else {
      if activeMessage == nil || canOverrideActive {  // excluding immediate messages, message should only be presented if not already presenting a message
        canOverrideActive = false
        presentNextMessage()
      }
    }
  }

  // returns true if a message was dismissed, false if none found
  public func dismissActiveMessage() -> Bool {
    guard let activeMessage = activeMessage else {
      presentNextMessage()
      return false
    }
    activeMessage.dismiss()
    self.activeMessage = nil
    presentNextMessage()
    return true
  }

  // removes a specific toast from the stack or dismisses if active
  // returns true if cleared, false if not found.
  public func clearMessage(toast: Toast) -> Bool {
    if let activeMessage = activeMessage where activeMessage == toast {
      return dismissActiveMessage()
    } else {
      for (n, stackedToast) in messageStack.enumerate() {
        if toast == stackedToast {
          messageStack.removeAtIndex(n)
          return true
        }
      }
      return false
    }
  }

  // returns true if a message was presented, false otherwise
  private func presentNextMessage() -> Bool {
    if let vc = viewControllerToPresentIn(), _message = messageStack.popLast() {
      _message.displayInViewController(vc)
      activeMessage = _message
      return true
    } else {
      return false
    }
  }

  private var activeMessage: Toast? = nil
  
}


extension Toaster: ToastDelegate {

  func toastDismissed(toast: Toast) {
    if toast == activeMessage {
      activeMessage = nil
      presentNextMessage()
    }
  }

}


public enum ToastPriority {
  case Low
  case High
  case Immediate
}
