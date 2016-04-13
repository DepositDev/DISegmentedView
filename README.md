# DISegmentedView

Minimalistic segmented view with buttons as single segment. Dot indicator used to show which segment currently selected.

![](example.gif)

## Usage

`DISegmentedView` is simple in use. All configurations fully compatible with InterfaceBuilder. Or you can create this component from code:

```swift
let newSegmentedView = DISegmentedView(names: ["first", "second", "third"], frame: CGRect(x: 0, y: 0, width: 100, height: 44))
view.addSubview(newSegmentedView)
```

And use it as usual `UIControl`: 

```swift
newSegmentedView.addTarget(self, action: #selector(valueDidChanged(_:)), forControlEvents: .ValueChanged)
```

## Installation

### CocoaPods

Add `pod 'DISegmentedView'` to your Podfile. 

### Manual Installation

Just copy `DISegmentedView` class to your project.

## Requirements

- Xcode 7.0
- iOS 8.0+

## License

DISegmentedView is available under the Apache 2.0 license. See the LICENSE file for more info.