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
        self.locationsUpdater = ^(NSArray *locations) {
            NSLog(@"%@", locations);
        };
        self.headingUpdater = ^(CLHeading *heading) {
            NSLog(@"%@", heading);
        };
        self.errorHandler = ^(NSError *error) {
            NSLog(@"%@", error);
        };
    }
    return self;
}

@end

@implementation RSLocationManagerForegroundProfile

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

@end

@implementation RSLocationManagerBackgroundProfile

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

@end
