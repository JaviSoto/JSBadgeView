//
//  JSBadgeSamplesViewController.m
//  JSBadgeView_SampleProject
//
//  Created by Javier Soto on 7/24/12.
//  Copyright (c) 2012 Javier Soto. All rights reserved.
//

#import "JSBadgeSamplesViewController.h"

#import "JSBadgeView.h"

#import <QuartzCore/QuartzCore.h>

#define kNumBadges 100

#define kViewBackgroundColor [UIColor colorWithRed:0.357 green:0.757 blue:0.357 alpha:1]

#define kSquareSideLength 64.0f
#define kSquareCornerRadius 10.0f
#define kMarginBetweenSquares 10.0f
#define kSquareColor [UIColor colorWithRed:0.004 green:0.349 blue:0.616 alpha:1]

@interface JSBadgeSamplesViewController ()

@end

@implementation JSBadgeSamplesViewController

- (void)loadView
{
    [super loadView];

    self.view.backgroundColor = kViewBackgroundColor;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    
    CGFloat viewWidth = self.view.frame.size.width;
    
    NSUInteger numberOfSquaresPerRow = floor(viewWidth / (kSquareSideLength + kMarginBetweenSquares));
    const CGFloat kInitialXOffset = (viewWidth - (numberOfSquaresPerRow * kSquareSideLength)) / (float)numberOfSquaresPerRow;
    CGFloat xOffset = kInitialXOffset;
    
    const CGFloat kInitialYOffset = kInitialXOffset;
    CGFloat yOffset = kInitialYOffset;
    
    CGRect rectangleBounds = CGRectMake(0.0f,
                                        0.0f,
                                        kSquareSideLength,
                                        kSquareSideLength);
    
    CGPathRef rectangleShadowPath = [UIBezierPath bezierPathWithRoundedRect:rectangleBounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(kSquareCornerRadius, kSquareCornerRadius)].CGPath;
    
    for (int i = 0; i < kNumBadges; i++)
    {
        UIView *rectangle = [[UIView alloc] initWithFrame:CGRectIntegral(CGRectMake(xOffset,
                                                                                    yOffset,
                                                                                    rectangleBounds.size.width,
                                                                                    rectangleBounds.size.height))];
        rectangle.backgroundColor = kSquareColor;
        rectangle.layer.cornerRadius = kSquareCornerRadius;
        rectangle.layer.shadowColor = [UIColor blackColor].CGColor;
        rectangle.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
        rectangle.layer.shadowOpacity = 0.4;
        rectangle.layer.shadowRadius = 1.0;
        rectangle.layer.shadowPath = rectangleShadowPath;        
        
        JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:rectangle alignment:JSBadgeViewAlignmentTopRight];
        badgeView.badgeText = [NSString stringWithFormat:@"%d", i];

        [scrollView addSubview:rectangle];
        [scrollView sendSubviewToBack:rectangle];
                
        xOffset += kSquareSideLength + kMarginBetweenSquares;
        
        if (xOffset > self.view.frame.size.width - kSquareSideLength)
        {
            xOffset = kInitialXOffset;
            yOffset += kSquareSideLength + kMarginBetweenSquares;
        }
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, yOffset);
}

@end
