//
//  RSMapViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/14/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSMapViewController.h"

#import <BMKMapView.h>

@interface RSMapViewController ()

@property (nonatomic, weak) IBOutlet BMKMapView *mapView;

@end

@implementation RSMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setShowMapScaleBar:YES];
}

@end
