//
//  Extensions.swift
//  ButteryToast
//
//  Created by creisterer on 10/30/17.
//  Copyright © 2017 Starry. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func topmostViewController() -> UIViewController {
    if let tc = self as? UITabBarController {
      return tc.selectedViewController?.topmostViewController() ?? self
    } else if let nc = self as? UINavigationController {
      return nc.visibleViewController?.topmostViewController() ?? self
    } else if let presentedVC = self.presentedViewController {
      return presentedVC.topmostViewController()
    } else {
      return self
    }
  }
  
}
