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

#import "JSBadgeView.h"

#import <QuartzCore/QuartzCore.h>

#define UICOLOR_RGB_BYTE(R, G, B, A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)/255.0f]

#define kDefaultBadgeTextColor [UIColor whiteColor]
#define kDefaultBadgeBackgroundColor [UIColor redColor]
#define kDefaultOverlayColor [UIColor colorWithWhite:1.0f alpha:0.3]

#define kDefaultBadgeTextFont [UIFont boldSystemFontOfSize:[UIFont systemFontSize]]

#define kDefaultBadgeShadowColor [UIColor clearColor]

#define kBadgeStrokeColor [UIColor whiteColor]
#define kBadgeStrokeWidth 2.0f

#define kShadowOffset CGSizeMake(0.0f, 2.0f)
#define kShadowColor [UIColor blackColor]
#define kShadowOpacity 0.3f

#define kBadgeHeight 20.0f
#define kBadgeTextSideMargin 10.0f

#define kBadgeCornerRadius 10.0f

#define kDefaultBadgeAlignment JSBadgeViewAlignmentTopRight

@interface _JSBadgeViewOverlay : CALayer

@property (nonatomic, strong) UIColor *badgeOverlayColor;

@end

@interface JSBadgeView()

@property (nonatomic, strong) UILabel *badgeTextLabel;
@property (nonatomic, strong) UIView *shadowView;

@property (nonatomic, strong) _JSBadgeViewOverlay *overlayLayer;

- (void)_init;
- (CGFloat)widthOfTextForCurrentSettings;
- (void)adjustShadowViewFrame;

@end

@implementation JSBadgeView

@synthesize badgeAlignment = _badgeAlignment;

@synthesize badgeTextLabel = _badgeTextLabel;

@synthesize shadowView = _shadowView;

@synthesize overlayLayer = _overlayLayer;

@synthesize badgeText = _badgeText;
@synthesize badgeTextColor = _badgeTextColor;
@synthesize badgeTextShadowOffset = _badgeTextShadowOffset;
@synthesize badgeTextShadowColor = _badgeTextShadowColor;
@synthesize badgeTextFont = _badgeTextFont;
@synthesize badgeBackgroundColor = _badgeBackgroundColor;
@synthesize badgePositionAdjustment = _badgePositionAdjustment;

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self _init];
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self _init];
    }

    return self;
}

- (void)_init
{
    self.overlayLayer = [[_JSBadgeViewOverlay alloc] init];
    _overlayLayer.frame = self.bounds;
    [self.layer addSublayer:_overlayLayer];
    
    self.badgeTextLabel = [[UILabel alloc] init];
    _badgeTextLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _badgeTextLabel.backgroundColor = [UIColor clearColor];
    _badgeTextLabel.textAlignment = UITextAlignmentCenter;

    [self addSubview:_badgeTextLabel];

    self.badgeAlignment = kDefaultBadgeAlignment;

    self.badgeBackgroundColor = kDefaultBadgeBackgroundColor;
    self.badgeTextColor = kDefaultBadgeTextColor;
    self.badgeTextShadowColor = kDefaultBadgeShadowColor;
    self.badgeTextFont = kDefaultBadgeTextFont;

    self.layer.cornerRadius = kBadgeCornerRadius;

    self.layer.borderColor = kBadgeStrokeColor.CGColor;
    self.layer.borderWidth = kBadgeStrokeWidth;

    self.shadowView = [[UIView alloc] initWithFrame:self.frame];
    _shadowView.backgroundColor = [UIColor blackColor];
    
    _shadowView.layer.cornerRadius = kBadgeCornerRadius;
    _shadowView.layer.shadowColor = kShadowColor.CGColor;
    _shadowView.layer.shadowOffset = kShadowOffset;
    _shadowView.layer.shadowOpacity = kShadowOpacity;
    _shadowView.layer.shadowRadius = 2.0f;

    self.clipsToBounds = YES;
}

- (void)dealloc
{
    [_shadowView removeFromSuperview];
}

#pragma mark - Public

- (void)addToView:(UIView *)parentView
{
    [parentView addSubview:self];
}

#pragma mark - Layout

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [newSuperview insertSubview:self.shadowView belowSubview:self];
    [self adjustShadowViewFrame];
}

- (void)layoutSubviews
{
    CGRect newFrame = self.frame;
    CGRect superviewFrame = self.superview.frame;
    
    CGFloat textWidth = [self widthOfTextForCurrentSettings];

    CGFloat viewHeight = kBadgeHeight;
    CGFloat viewWidth = MAX(textWidth + kBadgeTextSideMargin, kBadgeHeight); // Avoid a taller than wider view

    CGFloat superviewWidth = superviewFrame.size.width;
    CGFloat superviewHeight = superviewFrame.size.height;

    newFrame.size.width = viewWidth;
    newFrame.size.height = viewHeight;

    switch (self.badgeAlignment) {
        case JSBadgeViewAlignmentTopLeft:
            newFrame.origin.x = -ceilf((viewWidth / 2.0f));
            newFrame.origin.y = -ceilf(viewHeight / 2.0f);
            break;
        case JSBadgeViewAlignmentTopRight:
            newFrame.origin.x = superviewWidth - ceilf((viewWidth / 2.0f));
            newFrame.origin.y = -ceilf(viewHeight / 2.0f);
            break;
        case JSBadgeViewAlignmentTopCenter:
            newFrame.origin.x = ceilf((superviewWidth - viewWidth) / 2.0f);
            newFrame.origin.y = -ceilf(viewHeight / 2.0f);
            break;
        case JSBadgeViewAlignmentLeft:
            newFrame.origin.x = -ceilf((viewWidth / 2.0f));
            newFrame.origin.y = ceilf((superviewHeight - viewHeight) / 2.0f);
            break;
        case JSBadgeViewAlignmentRight:
            newFrame.origin.x = superviewWidth - ceilf((viewWidth / 2.0f));
            newFrame.origin.y = ceilf((superviewHeight - viewHeight) / 2.0f);
            break;
        case JSBadgeViewAlignmentBottomLeft:
            newFrame.origin.x = -ceilf((textWidth / 2.0f));
            newFrame.origin.y = superviewHeight -ceilf(viewHeight / 2.0f);
            break;
        case JSBadgeViewAlignmentBottomRight:
            newFrame.origin.x = superviewWidth - ceilf((viewWidth / 2.0f));
            newFrame.origin.y = superviewHeight - ceilf(viewHeight / 2.0f);
            break;
        case JSBadgeViewAlignmentBottomCenter:
            newFrame.origin.x = ceilf((superviewWidth - viewWidth) / 2.0f);
            newFrame.origin.y = superviewHeight -ceilf(viewHeight / 2.0f);
            break;
        default:
            NSAssert(NO, @"Unimplemented MSBadgeAligment type %d", self.badgeAlignment);
    }

    newFrame.origin.x += _badgePositionAdjustment.x;
    newFrame.origin.y += _badgePositionAdjustment.y;

    self.frame = newFrame;

    self.badgeTextLabel.frame = self.bounds;
}

#pragma mark - Private

- (CGFloat)widthOfTextForCurrentSettings
{
    return [self.badgeText sizeWithFont:self.badgeTextFont].width;
}

- (void)adjustShadowViewFrame
{
    CGFloat kShadowViewFrameInsetToKeepItBehind = 1.0f;
    self.shadowView.frame = CGRectInset(self.frame, kShadowViewFrameInsetToKeepItBehind, 0.0f);
}

#pragma mark - Setters

- (void)setFrame:(CGRect)frame
{
    frame.size.height = kBadgeHeight;

    [super setFrame:frame];

    [self adjustShadowViewFrame];
    self.overlayLayer.frame = self.bounds;
}

- (void)setBadgeAlignment:(JSBadgeViewAlignment)badgeAlignment
{
    if (badgeAlignment != _badgeAlignment)
    {
        _badgeAlignment = badgeAlignment;

        switch (badgeAlignment)
        {
            case JSBadgeViewAlignmentTopLeft:
                self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;break;
            case JSBadgeViewAlignmentTopRight:
                self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
                break;
            case JSBadgeViewAlignmentTopCenter:
                self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
                break;
            case JSBadgeViewAlignmentLeft:
                self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
                break;
            case JSBadgeViewAlignmentRight:
                self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
                break;
            case JSBadgeViewAlignmentBottomLeft:
                self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
                break;
            case JSBadgeViewAlignmentBottomRight:
                self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
                break;
            case JSBadgeViewAlignmentBottomCenter:
                self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            default:
                NSAssert(NO, @"Unimplemented MSBadgeAligment type %d", self.badgeAlignment);
        }

        [self setNeedsLayout];
    }
}

- (void)setBadgePositionAdjustment:(CGPoint)badgePositionAdjustment
{
    _badgePositionAdjustment = badgePositionAdjustment;

    [self setNeedsLayout];
}

- (void)setBadgeText:(NSString *)badgeText
{
    if (badgeText != _badgeText)
    {
        self.badgeTextLabel.text = badgeText;

        [self setNeedsLayout];
    }
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    self.badgeTextLabel.textColor = badgeTextColor;
}

- (void)setBadgeTextShadowColor:(UIColor *)badgeTextShadowColor
{
    self.badgeTextLabel.shadowColor = badgeTextShadowColor;
}

- (void)setBadgeTextShadowOffset:(CGSize)badgeTextShadowOffset
{
    self.badgeTextLabel.shadowOffset = badgeTextShadowOffset;
}

- (void)setBadgeTextFont:(UIFont *)badgeTextFont
{
    self.badgeTextLabel.font = badgeTextFont;
}

- (void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor
{
    self.backgroundColor = badgeBackgroundColor;
}

- (void)setBadgeOverlayColor:(UIColor *)badgeOverlayColor
{
    self.overlayLayer.badgeOverlayColor = badgeOverlayColor;
}

#pragma mark - Getters

- (NSString *)badgeText
{
    return self.badgeTextLabel.text;
}

- (UIColor *)badgeTextColor
{
    return self.badgeTextLabel.textColor;
}

- (UIColor *)badgeTextShadowColor
{
    return self.badgeTextLabel.shadowColor;
}

- (CGSize)badgeTextShadowOffset
{
    return self.badgeTextLabel.shadowOffset;
}

- (UIFont *)badgeTextFont
{
    return self.badgeTextLabel.font;
}

- (UIColor *)badgeBackgroundColor
{
    return self.backgroundColor;
}

- (UIColor *)badgeOverlayColor
{
    return self.overlayLayer.badgeOverlayColor;
}

@end

@implementation _JSBadgeViewOverlay

@synthesize badgeOverlayColor = _badgeOverlayColor;

- (id)init
{
    if ((self = [super init]))
    {
        self.contentsScale = [UIScreen mainScreen].scale;
        self.needsDisplayOnBoundsChange = YES;
    }
    
    return self;
}

- (void)drawInContext:(CGContextRef)ctx
{
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    CGRect rectForOverlayCircle = CGRectMake(0.0f,
                                             -height * 0.5,
                                             width,
                                             height);
    
    CGContextAddEllipseInRect(ctx, rectForOverlayCircle);
    CGContextSetFillColorWithColor(ctx, self.badgeOverlayColor.CGColor);
    
    CGContextDrawPath(ctx, kCGPathFill);
}

- (UIColor *)badgeOverlayColor
{
    if (!_badgeOverlayColor)
    {
        return kDefaultOverlayColor;
    }
    
    return _badgeOverlayColor;
}

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"badgeOverlayColor"])
    {
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}

@end
