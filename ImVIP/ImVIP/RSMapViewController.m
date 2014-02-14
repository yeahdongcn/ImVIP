//
//  RSMapViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/14/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSMapViewController.h"

#import "RSAppDelegate.h"

#import <BMKMapView.h>

#import <BMKSearch.h>

@interface RSMapViewController () <BMKMapViewDelegate, BMKSearchDelegate>

@property (nonatomic, weak) RSDynamicsDrawerViewController *dynamicsDrawerViewController;

@property (nonatomic, weak) IBOutlet BMKMapView *mapView;

@property (nonatomic, strong) BMKSearch *mapSearch;

@end

@implementation RSMapViewController

#pragma mark - NSObjet

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dynamicsDrawerViewController = ((RSAppDelegate *)[[UIApplication sharedApplication] delegate]).dynamicsDrawerViewController;
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.mapView setDelegate:self];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setShowMapScaleBar:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    
    self.dynamicsDrawerViewController.panePanGestureRecognizer.enabled = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    
    self.dynamicsDrawerViewController.panePanGestureRecognizer.enabled = YES;
}

#pragma mark - RSMapViewController

- (BMKSearch *)mapSearch
{
    if (!_mapSearch) {
        _mapSearch = [[BMKSearch alloc] init];
        [_mapSearch setDelegate:self];
    }
    return _mapSearch;
}

@end
