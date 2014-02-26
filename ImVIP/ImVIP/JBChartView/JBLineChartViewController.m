//
//  JBLineChartViewController.m
//  JBChartViewDemo
//
//  Created by Terry Worona on 11/5/13.
//  Copyright (c) 2013 Jawbone. All rights reserved.
//

#import "JBLineChartViewController.h"

// Views
#import "JBLineChartView.h"
#import "JBLineChartFooterView.h"
#import "JBChartInformationView.h"

#import "RSAppDelegate.h"

#import "RSDynamicsDrawerViewController.h"

// Numerics
CGFloat const kJBLineChartViewControllerChartHeight = 250.0f;
CGFloat const kJBLineChartViewControllerChartHeaderHeight = 75.0f;
CGFloat const kJBLineChartViewControllerChartHeaderPadding = 20.0f;
CGFloat const kJBLineChartViewControllerChartFooterHeight = 20.0f;
NSInteger const kJBLineChartViewControllerNumChartPoints = 27;
NSInteger const kJBLineChartViewControllerMaxPointValue = 100; // max random value

// Strings
NSString * const kJBLineChartViewControllerNavButtonViewKey = @"view";

@interface JBLineChartViewController () <JBLineChartViewDelegate, JBLineChartViewDataSource>

@property (nonatomic, strong) JBLineChartView *lineChartView;
@property (nonatomic, strong) JBChartInformationView *informationView;
@property (nonatomic, strong) NSArray *chartData;

// Buttons
- (void)chartToggleButtonPressed:(id)sender;

// Helpers
- (void)initData;

@property (nonatomic, weak) RSDynamicsDrawerViewController *dynamicsDrawerViewController;

@end

@implementation JBLineChartViewController

#pragma mark - Alloc/Init

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initData];
        
        self.dynamicsDrawerViewController = ((RSAppDelegate *)[[UIApplication sharedApplication] delegate]).dynamicsDrawerViewController;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initData];
        
        self.dynamicsDrawerViewController = ((RSAppDelegate *)[[UIApplication sharedApplication] delegate]).dynamicsDrawerViewController;
    }
    return self;
}

#pragma mark - Data

- (void)initData
{
    _chartData = [DataCenter getCardOpenLogs];
}

#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = kJBColorLineChartControllerBackground;
    
    self.lineChartView = [[JBLineChartView alloc] initWithFrame:CGRectMake(kJBNumericDefaultPadding, kJBNumericDefaultPadding + [[UIApplication sharedApplication] statusBarFrame].size.height + (self.navigationController.navigationBarHidden ? 0 : self.navigationController.navigationBar.bounds.size.height), self.view.bounds.size.width - (kJBNumericDefaultPadding * 2), kJBLineChartViewControllerChartHeight)];
    self.lineChartView.delegate = self;
    self.lineChartView.dataSource = self;
    self.lineChartView.headerPadding = kJBLineChartViewControllerChartHeaderPadding;
    self.lineChartView.backgroundColor = kJBColorLineChartBackground;
    
    JBLineChartFooterView *footerView = [[JBLineChartFooterView alloc] initWithFrame:CGRectMake(kJBNumericDefaultPadding, ceil(self.view.bounds.size.height * 0.5) - ceil(kJBLineChartViewControllerChartFooterHeight * 0.5), self.view.bounds.size.width - (kJBNumericDefaultPadding * 2), kJBLineChartViewControllerChartFooterHeight)];
    footerView.backgroundColor = [UIColor clearColor];
    footerView.leftLabel.text = kJBStringLabel0;
    footerView.leftLabel.textColor = [UIColor whiteColor];
    footerView.rightLabel.text = kJBStringLabel24;
    footerView.rightLabel.textColor = [UIColor whiteColor];
    footerView.sectionCount = kJBLineChartViewControllerNumChartPoints;
    self.lineChartView.footerView = footerView;
    
    [self.view addSubview:self.lineChartView];
    
    self.informationView = [[JBChartInformationView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, CGRectGetMaxY(self.lineChartView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.lineChartView.frame) - CGRectGetMaxY(self.navigationController.navigationBar.frame)) layout:JBChartInformationViewLayoutVertical];
    [self.informationView setValueAndUnitTextColor:[UIColor colorWithWhite:1.0 alpha:0.75]];
    [self.informationView setTitleTextColor:kJBColorLineChartHeader];
    [self.informationView setTextShadowColor:nil];
    [self.informationView setSeparatorColor:kJBColorLineChartHeaderSeparatorColor];
    [self.view addSubview:self.informationView];
    
    [self.lineChartView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.dynamicsDrawerViewController.panePanGestureRecognizer.enabled = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.lineChartView setState:JBChartViewStateExpanded animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.lineChartView setState:JBChartViewStateCollapsed];
    
    self.dynamicsDrawerViewController.panePanGestureRecognizer.enabled = NO;
    
    [self initData];
}

#pragma mark - JBLineChartViewDelegate

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView heightForIndex:(NSInteger)index
{
    return [(self.chartData)[index] floatValue];
}

- (void)lineChartView:(JBLineChartView *)lineChartView didSelectChartAtIndex:(NSInteger)index
{
    NSNumber *valueNumber = (self.chartData)[index];
    [self.informationView setValueText:[NSString stringWithFormat:@"%d", [valueNumber intValue]] unitText:kJBStringLabelTimes];
    [self.informationView setTitleText:[NSString stringWithFormat:@"%d%@", [kJBStringLabel0 intValue] + (int)index, kJBStringLabelHour]];
    [self.informationView setHidden:NO animated:YES];
}

- (void)lineChartView:(JBLineChartView *)lineChartView didUnselectChartAtIndex:(NSInteger)index
{
    [self.informationView setHidden:YES animated:YES];
}

#pragma mark - JBLineChartViewDataSource

- (NSInteger)numberOfPointsInLineChartView:(JBLineChartView *)lineChartView
{
    return [self.chartData count];
}

- (UIColor *)lineColorForLineChartView:(JBLineChartView *)lineChartView
{
    return kJBColorLineChartLineColor;
}

- (UIColor *)selectionColorForLineChartView:(JBLineChartView *)lineChartView
{
    return [UIColor whiteColor];
}

#pragma mark - Buttons

- (void)chartToggleButtonPressed:(id)sender
{
	UIView *buttonImageView = [self.navigationItem.rightBarButtonItem valueForKey:kJBLineChartViewControllerNavButtonViewKey];
    buttonImageView.userInteractionEnabled = NO;
    
    CGAffineTransform transform = self.lineChartView.state == JBChartViewStateExpanded ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformMakeRotation(0);
    buttonImageView.transform = transform;
    
    [self.lineChartView setState:self.lineChartView.state == JBChartViewStateExpanded ? JBChartViewStateCollapsed : JBChartViewStateExpanded animated:YES callback:^{
        buttonImageView.userInteractionEnabled = YES;
    }];
}

@end
