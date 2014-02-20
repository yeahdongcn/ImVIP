//
//  RSCardViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/7/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSCardViewController.h"

#import "RSAppDelegate.h"

#import "RSCardView.h"

#import "SFUIViewMacroses.h"

@interface RSCardViewController ()

@property (nonatomic, weak) RSDynamicsDrawerViewController *dynamicsDrawerViewController;

@property (nonatomic, weak) IBOutlet UIView *cardContentView;

@end

@implementation RSCardViewController

- (void)__onEdit
{
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dynamicsDrawerViewController = ((RSAppDelegate *)[[UIApplication sharedApplication] delegate]).dynamicsDrawerViewController;
    }
    return self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_edit"] style:UIBarButtonItemStylePlain target:self action:@selector(__onEdit)];
    
    RSCardView *cardView = (RSCardView *)[[[NSBundle mainBundle] loadNibNamed:@"RSCardView" owner:nil options:nil] firstObject];
    cardView.autoresizingMask = UIViewAutoresizingMake(@"W+H");
    [self.cardContentView addSubview:cardView];
}

@end
