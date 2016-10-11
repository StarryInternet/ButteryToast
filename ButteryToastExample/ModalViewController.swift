//
//  ModalViewController.swift
//  ButteryToast
//
//  Created by creisterer on 11/3/15.
//  Copyright © 2015 Starry. All rights reserved.
//

import UIKit
import ButteryToast

class ModalViewController: UIViewController {

  @IBAction func dismissPressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }

  @IBAction func successPressed(_ sender: UIButton) {
    let successToastView = UINib(nibName: "SuccessToast", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    let successToast = Toast(view: successToastView, dismissAfter: 2.0, height: 44)
    Toaster.sharedInstance.prepareToast(successToast, withPriority: .low)
  }

  @IBAction func failurePressed(_ sender: UIButton) {
    let failureToastView = UINib(nibName: "FailureToast", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    let failureToast = Toast(view: failureToastView, dismissAfter: 2.0, height: 44)
    Toaster.sharedInstance.prepareToast(failureToast, withPriority: .immediate)

  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    Toaster.sharedInstance.defaultViewController = self
  }

}
