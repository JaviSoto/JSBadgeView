## JSBadgeView

[![CI Status](http://img.shields.io/travis/JaviSoto/JSBadgeView.svg?style=flat)](https://travis-ci.org/JaviSoto/JSBadgeView)
[![Version](https://img.shields.io/cocoapods/v/JSBadgeView.svg?style=flat)](http://cocoapods.org/pods/JSBadgeView)
[![License](https://img.shields.io/cocoapods/l/JSBadgeView.svg?style=flat)](http://cocoapods.org/pods/JSBadgeView)
[![Platform](https://img.shields.io/cocoapods/p/JSBadgeView.svg?style=flat)](http://cocoapods.org/pods/JSBadgeView)

Customizable UIKit badge view like the one on applications in the iOS springboard.
Very optimized for performance: drawn entirely using CoreGraphics.

Snapshoot:

<img src="http://cl.ly/image/3G3J2k3n133W/JSBadgeView-iOS7.png" />

## Usage
- Clone the repository:

```bash
$ git clone git@github.com:JaviSoto/JSBadgeView.git
```

- Check out the sample project.

- Drag the ```JSBadgeView``` folder into your project.
- Include the header file:

```objc
#import "JSBadgeView.h"
```

- Create a ```JSBadgeView``` and attach it to a view at the position you like. Example:

```objc
JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:rectangle alignment:JSBadgeViewAlignmentTopRight];
badgeView.badgeText = @"3";
```
- Check the header file for all the things you can customize.

## [CocoaPods](http://cocoapods.org/):
- Add `pod 'JSBadgeView'` to your `Podfile`.
- You're done!

## `UIAppearance`
- You can customize all `JSBadgeView`s in your application, or the ones that are subviews of a specific type of view, using `UIAppearance`. Example:

```objc
[[JSBadgeView appearance] setBadgeBackgroundColor:UIColor.blackColor];
[[JSBadgeView appearance] setBadgeAlignment:JSBadgeViewAlignmentTopRight];
```

## Compatibility
- Supports ARC. If you want to use it in a project without ARC, mark ```JSBadgeView.m``` with the linker flag ```-fobjc-arc```.
- Compatible with iOS7.0+.

## MIT License
Copyright 2013 [Javier Soto](http://twitter.com/javisoto) (ios@javisoto.es)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
