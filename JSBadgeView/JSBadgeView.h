/*
 Copyright 2012 Javier Soto (ios@javisoto.es)
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <UIKit/UIKit.h>

typedef enum {
    JSBadgeViewAlignmentTopLeft,
    JSBadgeViewAlignmentTopRight,
    JSBadgeViewAlignmentTopCenter,
    JSBadgeViewAlignmentLeft,
    JSBadgeViewAlignmentRight,
    JSBadgeViewAlignmentBottomLeft,
    JSBadgeViewAlignmentBottomRight,
    JSBadgeViewAlignmentBottomCenter
} JSBadgeViewAlignment;

@interface JSBadgeView : UIView

@property (nonatomic, copy) NSString *badgeText;

#pragma mark - Customization

/**
 * @discussion simply set `badgeAligment` to any of the values, and add the `JSBadgeView`
 * to the view you want it to position in relation to. You can use the helper method
 * `addToView:` for this.
 */
@property (nonatomic, assign) JSBadgeViewAlignment badgeAlignment;

@property (nonatomic, strong) UIColor *badgeTextColor;
@property (nonatomic, assign) CGSize badgeTextShadowOffset;
@property (nonatomic, strong) UIColor *badgeTextShadowColor;

@property (nonatomic, strong) UIFont *badgeTextFont;

@property (nonatomic, strong) UIColor *badgeBackgroundColor;

/**
 * @discussion color of the overlay circle at the top.
 */
@property (nonatomic, strong) UIColor *badgeOverlayColor;

/**
 * @discussion allows to shift the badge by x and y points.
 */
@property (nonatomic, assign) CGPoint badgePositionAdjustment;

- (void)addToView:(UIView *)parentView;

@end
