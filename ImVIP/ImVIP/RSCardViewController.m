//
//  RSCardViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/7/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSCardViewController.h"

@interface RSCardViewController ()

@end

@implementation RSCardViewController

- (void)__edit
{
    
}

- (void)__back
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_back"] style:UIBarButtonItemStyleBordered target:self action:@selector(__back)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_edit"] style:UIBarButtonItemStyleBordered target:self action:@selector(__edit)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
