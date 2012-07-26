//
//  JSBadgeSamplesViewController.m
//  JSBadgeView_SampleProject
//
//  Created by Javier Soto on 7/24/12.
//  Copyright (c) 2012 Javier Soto. All rights reserved.
//

#import "JSBadgeSamplesViewController.h"

#import "JSBadgeView.h"

#define kNumBadges 50

#define kViewBackgroundColor [UIColor colorWithRed:197/255.0 green:147/255.0 blue:74/255.0 alpha:1.0f]

#define kSquareSideLength 75.0f
#define kMarginBetweenSquares 20.0f
#define kSquareColor [UIColor colorWithWhite:0.4 alpha:1.0f]

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
    
    for (int i = 0; i < kNumBadges; i++)
    {
        UIView *rectangle = [[UIView alloc] initWithFrame:CGRectIntegral(CGRectMake(xOffset,
                                                                                    yOffset,
                                                                                    kSquareSideLength,
                                                                                    kSquareSideLength))];
        rectangle.backgroundColor = kSquareColor;
        
        JSBadgeView *badgeView = [[JSBadgeView alloc] init];
        badgeView.badgeText = [NSString stringWithFormat:@"%d", i];
                
        [rectangle addSubview:badgeView];
        [scrollView addSubview:rectangle];
        [scrollView sendSubviewToBack:rectangle];
                
        xOffset += kSquareSideLength + kMarginBetweenSquares;
        
        if (xOffset > self.view.frame.size.width - kSquareSideLength)
        {
            xOffset = kInitialXOffset;
            yOffset += kSquareSideLength + kMarginBetweenSquares;
        }
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, yOffset + kSquareSideLength + kMarginBetweenSquares);
}

@end
