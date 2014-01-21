//
//  RSLocationManagerController.m
//  ImVIP
//
//  Created by R0CKSTAR on 1/20/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSLBSController.h"

NSString *const RSLBSControllerStartUpdatingLocationNotification = @"com.pdq.imvip.startUpdateLocation";
NSString *const RSLBSControllerStartUpdatingHeadingNotification  = @"com.pdq.imvip.startUpdateHeading";

typedef NS_OPTIONS(NSUInteger, RSLocationManagerControllerService) {
    RSLocationManagerControllerServiceNone     = 0,
    RSLocationManagerControllerServiceLocation = 1 << 0,
    RSLocationManagerControllerServiceHeading  = 1 << 1
};

@interface RSLBSController ()

@property (nonatomic, strong) RSLocationManager *locationManager;

@property (nonatomic) RSLocationManagerControllerService service;

@property (nonatomic) BOOL isServiceDenied;

@end

@implementation RSLBSController

- (void)__didBecomeActive:(NSNotification *)notification
{
    if (self.isServiceDenied) {
        if (self.service & RSLocationManagerControllerServiceLocation) {
            [self.locationManager startUpdatingLocation];
        }
        
        if (self.service & RSLocationManagerControllerServiceHeading) {
            [self.locationManager startUpdatingHeading];
        }
        
        self.isServiceDenied = NO;
    }
}

- (void)__startUpdatingLocation:(NSNotification *)notification
{
    [self.locationManager startUpdatingLocation];
    
    self.service |= RSLocationManagerControllerServiceLocation;
}

- (void)__startUpdatingHeading:(NSNotification *)notification
{
    [self.locationManager startUpdatingHeading];
    
    self.service |= RSLocationManagerControllerServiceHeading;
}

+ (instancetype)controller
{
    static RSLBSController *controller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[self alloc] init];
    });
    return controller;
}

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__didBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__startUpdatingLocation:) name:RSLBSControllerStartUpdatingLocationNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__startUpdatingHeading:) name:RSLBSControllerStartUpdatingHeadingNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (RSLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[RSLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        
        __weak __typeof(self)weakSelf = self;
        _locationManager.serviceRestarter = ^(NSError *error) {
            if ([error code] == kCLErrorDenied) {
                if ([error code] == kCLErrorDenied) {
                    weakSelf.isServiceDenied = YES;
                    
                    if (weakSelf.service & RSLocationManagerControllerServiceLocation) {
                        [weakSelf.locationManager stopUpdatingLocation];
                    }
                    
                    if (weakSelf.service & RSLocationManagerControllerServiceHeading) {
                        [weakSelf.locationManager stopUpdatingHeading];
                    }
                }
            }
        };
    }
    return _locationManager;
}

@end
