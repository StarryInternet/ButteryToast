//
//  Toaster.swift
//  ButteryToast
//
//  Created by creisterer on 11/3/15.
//  Copyright © 2015 Starry. All rights reserved.
//

import UIKit

// defines the orientation of presented toasts
public enum Orientation {
  case top
  case bottom
}

/**
 Toaster manages a queue of Toasts in OperationQueue (FIFO)
 */
public class Toaster {
  
  public static let shared = Toaster()
  
  public var window: UIWindow?
  
  // set the toast orientation to top by default
  public var orientation: Orientation = .top
  
  public func add(_ toast: Toast) {
    toast.toaster = self
    queue.addOperation(toast)
  }
  
  private let queue: OperationQueue = {
    let queue = OperationQueue()
    queue.maxConcurrentOperationCount = 1
    return queue
  }()
  
  func viewControllerToPresentIn() -> UIViewController? {
    return window?.rootViewController?.topmostViewController()
  }
  
}
