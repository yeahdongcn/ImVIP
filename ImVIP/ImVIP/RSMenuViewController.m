//
//  RSLeftViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 1/16/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSMenuViewController.h"

#import "RSAppDelegate.h"

#import "RSTitleView.h"

new_class(RSMenuTableHeaderView, UIView)

@interface RSMenuViewController ()

@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;

@property (nonatomic, strong) NSDictionary *paneViewControllerTitles;

@property (nonatomic, strong) NSDictionary *paneViewControllerImages;

@property (nonatomic, strong) NSDictionary *paneViewControllerIdentifiers;

@property (nonatomic, strong) UIBarButtonItem *paneRevealLeftBarButtonItem;

@property (nonatomic, strong) UIBarButtonItem *paneRevealRightBarButtonItem;

@end

@implementation RSMenuViewController

- (void)__initialize
{
    self.dynamicsDrawerViewController = ((RSAppDelegate *)[[UIApplication sharedApplication] delegate]).dynamicsDrawerViewController;
    self.paneViewControllerType = NSUIntegerMax;
    self.paneViewControllerTitles = @{
                                      @(RSPaneViewControllerTypeCards)      : @"Cards",
                                      @(RSPaneViewControllerTypeLBS)        : @"LBS",
                                      @(RSPaneViewControllerTypeSale)       : @"Sale",
                                      @(RSPaneViewControllerTypeBarcodes)   : @"Barcodes",
                                      @(RSPaneViewControllerTypeStatistics) : @"Statistics",
                                      };
    self.paneViewControllerImages = @{
                                      @(RSPaneViewControllerTypeCards)      : @"menu_cards",
                                      @(RSPaneViewControllerTypeLBS)        : @"menu_lbs",
                                      @(RSPaneViewControllerTypeSale)       : @"menu_sale",
                                      @(RSPaneViewControllerTypeBarcodes)   : @"menu_barcodes",
                                      @(RSPaneViewControllerTypeStatistics) : @"menu_statistics",
                                      };
    self.paneViewControllerIdentifiers = @{
                                           @(RSPaneViewControllerTypeCards) : @"Cards",
                                           @(RSPaneViewControllerTypeLBS) : @"Cards",
                                           @(RSPaneViewControllerTypeSale) : @"Cards",
                                           @(RSPaneViewControllerTypeBarcodes) : @"Cards",
                                           @(RSPaneViewControllerTypeStatistics) : @"Cards",
                                           };
}

- (void)__openMenu
{
    [self.dynamicsDrawerViewController setPaneState:MSDynamicsDrawerPaneStateOpen inDirection:MSDynamicsDrawerDirectionLeft animated:YES allowUserInterruption:YES completion:nil];
}

- (void)__openProfile
{
    [self.dynamicsDrawerViewController setPaneState:MSDynamicsDrawerPaneStateOpen inDirection:MSDynamicsDrawerDirectionRight animated:YES allowUserInterruption:YES completion:nil];
}

- (RSPaneViewControllerType)__paneViewControllerTypeForIndexPath:(NSIndexPath *)indexPath
{
    return [indexPath row];
}

#pragma mark - NSObject

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self __initialize];
    }
    return self;
}

#pragma mark - UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self __initialize];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    });
}

#pragma mark - RSMenuViewController

- (void)transitionToViewController:(RSPaneViewControllerType)paneViewControllerType
{
    // Close pane if already displaying the pane view controller
    if (paneViewControllerType == self.paneViewControllerType) {
        [self.dynamicsDrawerViewController setPaneState:MSDynamicsDrawerPaneStateClosed animated:YES allowUserInterruption:YES completion:nil];
        return;
    }
    
    BOOL animateTransition = self.dynamicsDrawerViewController.paneViewController != nil;
    
    UIViewController *paneViewController = [self.storyboard instantiateViewControllerWithIdentifier:self.paneViewControllerIdentifiers[@(paneViewControllerType)]];
    RSTitleView *titleView = (RSTitleView *)[[[NSBundle mainBundle] loadNibNamed:@"RSTitleView" owner:nil options:nil] firstObject];
    titleView.label.text = self.paneViewControllerTitles[@(paneViewControllerType)];
    titleView.showIndicator = YES;
    paneViewController.navigationItem.titleView = titleView;
    
    self.paneRevealLeftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(__openMenu)];
    paneViewController.navigationItem.leftBarButtonItem = self.paneRevealLeftBarButtonItem;
    
    self.paneRevealRightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_profile"] style:UIBarButtonItemStylePlain target:self action:@selector(__openProfile)];
    paneViewController.navigationItem.rightBarButtonItem = self.paneRevealRightBarButtonItem;
    
    UINavigationController *paneNavigationViewController = [[UINavigationController alloc] initWithRootViewController:paneViewController];
    [self.dynamicsDrawerViewController setPaneViewController:paneNavigationViewController animated:animateTransition completion:nil];
    
    self.paneViewControllerType = paneViewControllerType;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.imageView.image = [UIImage imageNamed:self.paneViewControllerImages[@([self __paneViewControllerTypeForIndexPath:indexPath])]];
    cell.textLabel.text = self.paneViewControllerTitles[@([self __paneViewControllerTypeForIndexPath:indexPath])];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSPaneViewControllerType paneViewControllerType = [self __paneViewControllerTypeForIndexPath:indexPath];
    [self transitionToViewController:paneViewControllerType];
}

#pragma mark - MSDynamicsDrawerViewControllerDelegate

- (void)dynamicsDrawerViewController:(MSDynamicsDrawerViewController *)dynamicsDrawerViewController didUpdateToPaneState:(MSDynamicsDrawerPaneState)state
{
    // Ensure that the pane's table view can scroll to top correctly
    self.tableView.scrollsToTop = (state == MSDynamicsDrawerPaneStateOpen);
}

@end
