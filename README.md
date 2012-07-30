## JSBadgeView

Customizable UIKit badge view like the one on applications in the iOS springboard.
Very optimized for performance: drawn entirely using CoreGraphics.

<img src="http://f.cl.ly/items/1L3k0z0a3X3i353M1G0h/JSBadgeView.png" />

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

## Dependencies

```JSBadgeView``` requires your application to be linked against the ```QuartzCore.framework``` framework.

## Compatibility
- Supports ARC. If you want to use it in a project without ARC, mark ```JSBadgeView.m``` with the linker flag ```-fobjc-arc```.
- Compatible with iOS4.3+.

## License
Copyright 2012 [Javier Soto](http://twitter.com/javisoto) (ios@javisoto.es)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
 limitations under the License. 

Attribution is not required, but appreciated.