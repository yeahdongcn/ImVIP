//
//  RSScanViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/14/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSScanViewController.h"

#import "RSTitleView.h"

@interface RSScanViewController ()

@end

@implementation RSScanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (!self.navigationItem.titleView) {
        RSTitleView *titleView = (RSTitleView *)[[[NSBundle mainBundle] loadNibNamed:@"RSTitleView" owner:nil options:nil] firstObject];
        titleView.label.text = RSLocalizedString(@"Scan Code");
        self.navigationItem.titleView = titleView;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
