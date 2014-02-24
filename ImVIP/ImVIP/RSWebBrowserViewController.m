//
//  RSWebBrowserViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/24/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSWebBrowserViewController.h"

@interface RSWebBrowserViewController ()

@end

@implementation RSWebBrowserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

+ (RSWebBrowserViewController *)webBrowser {
    RSWebBrowserViewController *webBrowserViewController = [[RSWebBrowserViewController alloc] initWithOptions:nil];
    return webBrowserViewController;
}

@end
