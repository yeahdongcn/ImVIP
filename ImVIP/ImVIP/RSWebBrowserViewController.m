//
//  RSWebBrowserViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/24/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSWebBrowserViewController.h"

#import "RSAppDelegate.h"

#import <ColorUtils.h>

@interface RSWebBrowserViewController ()

@property (nonatomic, weak) RSDynamicsDrawerViewController *dynamicsDrawerViewController;

@end

@implementation RSWebBrowserViewController

- (id)initWithOptions:(NSDictionary *)options
{
    self = [super initWithOptions:options];
    if (self) {
        self.dynamicsDrawerViewController = ((RSAppDelegate *)[[UIApplication sharedApplication] delegate]).dynamicsDrawerViewController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    
    self.webView.backgroundColor = [UIColor colorWithRGBValue:0xf3f3f7];
}

+ (RSWebBrowserViewController *)webBrowser {
    RSWebBrowserViewController *webBrowserViewController = [[RSWebBrowserViewController alloc] initWithOptions:nil];
    return webBrowserViewController;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.dynamicsDrawerViewController.panePanGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.dynamicsDrawerViewController.panePanGestureRecognizer.enabled = YES;
}

@end
