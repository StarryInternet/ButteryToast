# ButteryToast
<p align="left">
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage compatible" /></a>
</p>

Simple Toasting Library for iOS written in Swift.
Plays nicely with Autolayout.

## Requirements
- iOS 9.0+
- Xcode 10
- Swift 4.2

## Usage

### How to create and present a toast
Toasts are presented by a `Toaster`. There is a shared instance for use in your app, as messages can be queued and may be presented in a different view controller than they were created on.
Toasts are messages that wrap any UIView. Toasts will be sized to the width of the containing view. Height is determined by autolayout UNLESS the view's bound's height exceeds that.

```swift
import ButteryToast

class ToastyViewController: UIViewController {
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    let labelToToast = UILabel(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
    labelToToast.text = "View Appeared!"
    labelToToast.backgroundColor = UIColor.lightGray
    let toast = Toast(view: labelToToast)
    Toaster.shared.add(toast)
  }
}
```

### Presentation Options
 Toasters have a variable `orientation` to determine the presentation style of their toasts.  This value is set to `top` by default.
 Toasts also can be initialized with an `orientation`  which overrides the `Toaster` level `orientation`.  Currently `top` and `bottom` are the options for `orientation`.
 Toast default animation is a simple (but effective) fade. Slide in is also supported by initializing toast with an `animation`. Currently `fade` and `slide` are the options for `animation`.

## Installation

### Carthage
[Carthage](https://github.com/Carthage/Carthage) is a simple, decentralized dependency manager for Cocoa.

Add ButteryToast into your project's `Cartfile`:

```ogdl
github "ProjectDecibel/ButteryToast" ~> 0.1
```
