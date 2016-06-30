//
//  SecondViewController.swift
//  ButteryToast
//
//  Created by creisterer on 11/3/15.
//  Copyright © 2015 Starry. All rights reserved.
//

import UIKit
import ButteryToast

class SecondViewController: UIViewController {

  @IBAction func successPressed(sender: UIButton) {
    let successToastView = UINib(nibName: "SuccessToast", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    let successToast = Toast(view: successToastView, dismissAfter: 2.0, height: 44)
    Toaster.sharedInstance.prepareToast(successToast, withPriority: .Low)
  }

  @IBAction func failurePressed(sender: UIButton) {
    let faliureToastView = UINib(nibName: "FailureToast", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    let failureToast = Toast(view: faliureToastView, dismissAfter: 2.0, height: 44)
    Toaster.sharedInstance.prepareToast(failureToast, withPriority: .Immediate)

  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    Toaster.sharedInstance.defaultViewController = self
  }

}
