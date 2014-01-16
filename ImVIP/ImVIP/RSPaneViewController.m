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
    
    self.carousel.type = iCarouselTypeRotary;
    self.carousel.vertical = YES;
    self.carousel.clipsToBounds = YES;
}

#pragma mark - iCarouselDataSource

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 100;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    if (view) {
        
    } else {
        RSCardView *cardView = [[[NSBundle mainBundle] loadNibNamed:@"RSCardView" owner:nil options:nil] firstObject];
        cardView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
        cardView.borderColor = [UIColor purpleColor];
        view = cardView;
    }
    return view;
}

@end
