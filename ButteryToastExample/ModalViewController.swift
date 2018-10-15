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
    let successToast = Toast(view: successToastView, orientation: .top)
    Toaster.shared.add(successToast)
  }

  @IBAction func failurePressed(_ sender: UIButton) {
    let failureToastView = UINib(nibName: "FailureToast", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    let failureToast = Toast(view: failureToastView, orientation: .bottom)
    Toaster.shared.add(failureToast)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}
