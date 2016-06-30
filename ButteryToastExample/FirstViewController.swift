//
//  FirstViewController.swift
//  ButteryToastExample
//
//  Created by creisterer on 11/3/15.
//  Copyright © 2015 Starry. All rights reserved.
//

import UIKit
import ButteryToast

class FirstViewController: UIViewController {

  @IBAction func successPressed(sender: UIButton) {
    let successToastView = UINib(nibName: "SuccessToast", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    let successToast = Toast(view: successToastView, height: 44)
    Toaster.sharedInstance.prepareToast(successToast)
  }

  @IBAction func failurePressed(sender: UIButton) {
    let faliureToastView = UINib(nibName: "FailureToast", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    let failureToast = Toast(view: faliureToastView, height: 44)
    Toaster.sharedInstance.prepareToast(failureToast, withPriority: .Immediate)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let toastAppearance = ToastView.appearance()
    toastAppearance.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    Toaster.sharedInstance.defaultViewController = self
  }


}

 