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

  @IBAction func successPressed(_ sender: UIButton) {
    let successToastView = UINib(nibName: "SuccessToast", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    let successToast = Toast(view: successToastView)
    Toaster.shared.orientation = .bottom
    Toaster.shared.add(successToast)
  }

  @IBAction func failurePressed(_ sender: UIButton) {
    let failureToastView = UINib(nibName: "FailureToast", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    let failureToast = Toast(view: failureToastView, orientation: .top)
    
    Toaster.shared.add(failureToast)
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }

}

 
