# ButteryToast
<p align="left">
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage compatible" /></a>
</p>

Simple Toasting Library for iOS written in Swift.
Plays nicely with Autolayout.

## Requirements
- iOS 8.0+
- Xcode 7.0+

## Usage

### How to create and present a toast
Toasts are presented by a `Toaster`. There is a shared instance for use in your app, as messages can be queued and may be presented in a different view controller than they were created on.
Toasts are messages that wrap any UIView. Toasts will try to respect autolayout constraints of the view. The width of the Toast will be set to the width of the view the Toast is presented in. Optionally, an explicit height can be passed to a Toast.

```swift
import ButteryToast

class ToastyViewController: UIViewController {
	override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

		let labelToToast = UILabel()
		labelToToast.text = "View Appeared!"
		labelToToast.backgroundColor = UIColor.lightGrayColor()
    	let toast = Toast(view: labelToToast, height: 44)
    	Toaster.sharedInstance.prepareToast(toast)
	}
}
```

### Toaster behavior
A `Toaster` manages a queue of `Toast` messages and decides when and where they should be presented. Toasts are taken off the queue sequentially and presented as long as another toast is not currently being presented. Toasts added with High priority will be added to the top of the queue, while Low Priority will be added to the end. Toasts with Immediate priority will be presented even if another Toast is currently being presented.
```swift
import ButteryToast

class ToastyViewController: UIViewController {
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    Toaster.sharedInstance.defaultViewController = self


    let processingToastView = UILabel()
    processingToastView.text = "Processing change..."
    let processingToast = Toast(view: processingToastView)
    Toaster.sharedInstance.prepareToast(processingToast)

    let successToastView = UILabel()
    successToastView.text = "Change Successful!"
    let successToast = Toast(view: successToastView)
    // dismiss processing toast and immediately present success toast
    Toaster.sharedInstance.prepareToast(successToast, withPriority: .Immediate)

  }
}
```



### Customizing appearance
`Toast`s are initialized with a custom view you provide. The custom view is presented within a container `ToastView`.
`ToastView` can be customized using the appearance proxy.
```swift
let toastAppearance = ToastView.appearance()
toastAppearance.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
```


## Installation

### Carthage
[Carthage](https://github.com/Carthage/Carthage) is a simple, decentralized dependency manager for Cocoa.

Add ButteryToast into your project's `Cartfile`:

```ogdl
github "ProjectDecibel/ButteryToast" ~> 0.1
```