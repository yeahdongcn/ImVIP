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

#import "RSScanViewController.h"

#import "RSWebBrowserViewController.h"

#import <AVFoundation/AVFoundation.h>

#import <SIAlertView.h>

new_class(RSMenuTableHeaderView, UIView)

@interface RSMenuViewController ()

@property (nonatomic, weak) RSDynamicsDrawerViewController *dynamicsDrawerViewController;

@property (nonatomic, strong) NSDictionary *paneViewControllerTitles;

@property (nonatomic, strong) NSDictionary *paneViewControllerImages;

@property (nonatomic, strong) NSDictionary *paneViewControllerIdentifiers;

@property (nonatomic, strong) NSMutableDictionary *paneViewControllerNavigationViewControllers;

@property (nonatomic, strong) UIBarButtonItem *paneRevealLeftBarButtonItem;

@property (nonatomic, strong) UIBarButtonItem *paneRevealRightBarButtonItem;

@property (nonatomic) BOOL barcodesFound;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation RSMenuViewController

- (void)__initialize
{
    self.dynamicsDrawerViewController = ((RSAppDelegate *)[[UIApplication sharedApplication] delegate]).dynamicsDrawerViewController;
    self.paneViewControllerType = NSUIntegerMax;
    self.paneViewControllerTitles = @{
                                      @(RSPaneViewControllerTypeCards)      : RSLocalizedString(@"My Cards"),
                                      @(RSPaneViewControllerTypeLBS)        : RSLocalizedString(@"Nearby Businesses"),
//                                      @(RSPaneViewControllerTypeSale)       : RSLocalizedString(@"Promotions"),
                                      @(RSPaneViewControllerTypeBarcodes)   : RSLocalizedString(@"Barcode Scanning"),
                                      @(RSPaneViewControllerTypeStatistics) : RSLocalizedString(@"Statistics"),
                                      };
    self.paneViewControllerImages = @{
                                      @(RSPaneViewControllerTypeCards)      : @"menu_cards",
                                      @(RSPaneViewControllerTypeLBS)        : @"menu_lbs",
//                                      @(RSPaneViewControllerTypeSale)       : @"menu_sales",
                                      @(RSPaneViewControllerTypeBarcodes)   : @"menu_barcodes",
                                      @(RSPaneViewControllerTypeStatistics) : @"menu_statistics",
                                      };
    self.paneViewControllerIdentifiers = @{
                                           @(RSPaneViewControllerTypeCards)      : @"Cards",
                                           @(RSPaneViewControllerTypeLBS)        : @"Map",
//                                           @(RSPaneViewControllerTypeSale)       : @"Sales",
                                           @(RSPaneViewControllerTypeBarcodes)   : @"Scanner",
                                           @(RSPaneViewControllerTypeStatistics) : @"Statistics",
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

- (NSMutableDictionary *)paneViewControllerNavigationViewControllers
{
    if (!_paneViewControllerNavigationViewControllers) {
        _paneViewControllerNavigationViewControllers = [NSMutableDictionary new];
    }
    return _paneViewControllerNavigationViewControllers;
}

- (void)transitionToViewController:(RSPaneViewControllerType)paneViewControllerType
{
    // Close pane if already displaying the pane view controller
    if (paneViewControllerType == self.paneViewControllerType) {
        [self.dynamicsDrawerViewController setPaneState:MSDynamicsDrawerPaneStateClosed animated:YES allowUserInterruption:YES completion:nil];
        return;
    }
    
    BOOL animateTransition = self.dynamicsDrawerViewController.paneViewController != nil;
    
    UINavigationController *paneNavigationViewController = self.paneViewControllerNavigationViewControllers[@(paneViewControllerType)];
    if (!paneNavigationViewController) {
        NSString *identifier = self.paneViewControllerIdentifiers[@(paneViewControllerType)];
        UIViewController *paneViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        
        RSTitleView *titleView = (RSTitleView *)[[[NSBundle mainBundle] loadNibNamed:@"RSTitleView" owner:nil options:nil] firstObject];
        titleView.label.text = self.paneViewControllerTitles[@(paneViewControllerType)];
        titleView.showIndicator = YES;
        paneViewController.navigationItem.titleView = titleView;
        
        self.paneRevealLeftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(__openMenu)];
        paneViewController.navigationItem.leftBarButtonItem = self.paneRevealLeftBarButtonItem;
        
        self.paneRevealRightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_profile"] style:UIBarButtonItemStylePlain target:self action:@selector(__openProfile)];
        paneViewController.navigationItem.rightBarButtonItem = self.paneRevealRightBarButtonItem;
        
        paneNavigationViewController = [[UINavigationController alloc] initWithRootViewController:paneViewController];
        
        (self.paneViewControllerNavigationViewControllers)[@(paneViewControllerType)] = paneNavigationViewController;
        
        if ([identifier isEqualToString:@"Scanner"]) {
            RSScanViewController *viewController = (RSScanViewController *)paneViewController;
            viewController.barcodesHandler = [^(NSArray *barcodes) {
                if ([barcodes count] <= 0) {
                    return;
                }
                
                if (self.barcodesFound) {
                    return;
                }
                self.barcodesFound = YES;
                
                if (!self.audioPlayer) {
                    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                         pathForResource:@"qrcode_found"
                                                         ofType:@"wav"]];
                    NSError *error = nil;
                    self.audioPlayer = [[AVAudioPlayer alloc]
                                        initWithContentsOfURL:url
                                        error:&error];
                    if (error) {
                        self.audioPlayer = nil;
                    }
                }
                [self.audioPlayer play];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:RSLocalizedString(@"Barcode Found") andMessage:[NSString stringWithFormat:RSLocalizedString(@"%d barcodes have been found"), [barcodes count]]];
                    for (int i = 0; i < [barcodes count]; i++) {
                        NSString *title = [barcodes[i] stringValue];
                        [alertView addButtonWithTitle:title type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                            RSWebBrowserViewController *viewController = [RSWebBrowserViewController webBrowser];
                            viewController.text = title;
                            if ([title hasPrefix:@"http://"] || [title hasPrefix:@"https://"]) {
                                [viewController loadURLString:title];
                            } else {
                                [viewController loadURLString:[NSString stringWithFormat:@"http://www.baidu.com/s?wd=%@", title]];
                            }
                            [paneNavigationViewController pushViewController:viewController animated:YES];
                            
                            double delayInSeconds = 1;
                            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                self.barcodesFound = NO;
                            });
                        }];
                    }
                    [alertView addButtonWithTitle:RSLocalizedString(@"Cancel") type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
                        self.barcodesFound = NO;
                    }];
                    
                    alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromBottom;
                    
                    [alertView show];
                });
            } copy];
        }
    }
    
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
    return [self.paneViewControllerTitles count];
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
