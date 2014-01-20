//
//  RSLocationManagerController.m
//  ImVIP
//
//  Created by R0CKSTAR on 1/20/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSLocationManagerController.h"

@interface RSLocationManagerController ()

@property (nonatomic, strong) RSLocationManager *locationManager;

@end

@implementation RSLocationManagerController

- (void)__didBecomeActive:(NSNotification *)notification
{
    [self.locationManager updateProfile:self.foregroundProfile];
}

- (void)__willResignActive:(NSNotification *)notification
{
    [self.locationManager updateProfile:self.backgroundProfile];
}

+ (instancetype)controller
{
    static RSLocationManagerController *controller = nil;
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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__willResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
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
    }
    return _locationManager;
}

@end
