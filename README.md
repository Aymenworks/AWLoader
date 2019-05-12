# AWLoader
 
AWLoader is a UI  Component that allows you to integrate loader that fits your needs within your app.

## Overview

### Appareance

![AWLoader all gif](./AWLoader-all.gif)

###  Behind the scenes

As simple as:
![Whimsical AWLoader](./AWLoaderWhimsical.png)

## 🔶 Requirements

- iOS 9.0+
- Swift 5.0

## 👨🏻‍💻 Usage

### Normal loader

#### Usage
```swift
let loader = AWLoader(showInView: view,
                      animationDuration: 1,
                      blurStyle: .light,
                      shape: .rounded(6),
                      containerBackgroundColor: .white,
                      lineWidth: 2,
                      strokeColor: .darkGray)
loader.show()

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    loader.hide()
}
```

### Gradient loader

#### Usage
```swift
let gradientLoader = AWGradientLoader(showInView: self.view,
                                      animationDuration: 0.7,
                                      blurStyle: .dark,
                                      shape: .rounded(6),
                                      containerBackgroundColor: .white,
                                      gradientColors: [.purple, .black, .purple],
                                      gradientLocations: [0.2, 0.5, 1]),
                                      borderWidth: CGFloat = 1)
gradientLoader.show()

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    gradientLoader.hide()
}
```

## Installation

### CocoaPods

```pod 'AWLoader'```

### Carthage

```github "Aymenworks/AWLoader"```


## License

AWLoader is released under the MIT license.
