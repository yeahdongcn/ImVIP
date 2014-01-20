//
//  RSLocationManagerProfile.m
//  ImVIP
//
//  Created by R0CKSTAR on 14-1-19.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import "RSLocationManagerProfile.h"

@implementation RSLocationManagerProfile

- (id)init
{
    self = [super init];
    if (self) {
        self.distanceFilter = kCLDistanceFilterNone;
        self.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return self;
}

@end

@implementation RSLocationManagerForegroundProfile

- (id)init
{
    self = [super init];
    if (self) {
        self.distanceFilter = kCLDistanceFilterNone;
        self.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationsUpdater = ^(NSArray *locations) {
            NSLog(@"fg %@", locations);
        };
        self.headingUpdater = ^(CLHeading *heading) {
            NSLog(@"fg %@", heading);
        };
        self.errorHandler = ^(NSError *error) {
            NSLog(@"fg %@", error);
        };
    }
    return self;
}

@end

@implementation RSLocationManagerBackgroundProfile

- (id)init
{
    self = [super init];
    if (self) {
        self.distanceFilter = 5;
        self.desiredAccuracy = kCLLocationAccuracyKilometer;
        self.locationsUpdater = ^(NSArray *locations) {
            NSLog(@"bg %@", locations);
        };
        self.headingUpdater = ^(CLHeading *heading) {
            NSLog(@"bg %@", heading);
        };
        self.errorHandler = ^(NSError *error) {
            NSLog(@"bg %@", error);
        };
    }
    return self;
}

@end
