//
//  RSMapViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/14/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSMapViewController.h"

#import <BMKMapView.h>

@interface RSMapViewController () <BMKMapViewDelegate>

@property (nonatomic, weak) IBOutlet BMKMapView *mapView;

@end

@implementation RSMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setShowMapScaleBar:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
}

@end
