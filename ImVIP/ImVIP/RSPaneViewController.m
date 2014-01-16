//
//  RSRootViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 1/16/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSPaneViewController.h"

#import "iCarousel.h"

#import "RSCardView.h"

@interface RSPaneViewController () <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, weak) IBOutlet iCarousel *carousel;

@end

@implementation RSPaneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - iCarouselDataSource

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 2;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    if (view) {
        
    } else {
        RSCardView *cardView = [[[NSBundle mainBundle] loadNibNamed:@"RSCardView" owner:nil options:nil] firstObject];
        cardView.borderColor = [UIColor purpleColor];
        view = cardView;
    }
    return view;
}

@end
