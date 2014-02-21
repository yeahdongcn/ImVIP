//
//  RSBigCardViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/21/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSBigCardViewController.h"

#import "ANBlurredImageView.h"

@interface RSBigCardViewController ()

@property (nonatomic, weak) IBOutlet ANBlurredImageView *blurredView;

@property (nonatomic, weak) IBOutlet UIButton *closeButton;

@end

@implementation RSBigCardViewController

- (void)__clicked
{
    [self.blurredView blurOutAnimationWithDuration:0.3f completion:^{
        [self.navigationController setNavigationBarHidden:NO];
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.closeButton addTarget:self action:@selector(__clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.blurredView setImage:self.snapshot];
    [self.blurredView setBlurAmount:1];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.blurredView blurInAnimationWithDuration:0.3f];
    });
}

@end
