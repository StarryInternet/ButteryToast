//
//  Toaster.swift
//  ButteryToast
//
//  Created by creisterer on 11/3/15.
//  Copyright © 2015 Starry. All rights reserved.
//

import UIKit

/**
 Toaster manages a queue of Toasts in OperationQueue (FIFO)
 */
open class Toaster {
  
  open static let shared = Toaster()
  
  open var window: UIWindow?
  
  open func add(_ toast: Toast) {
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
