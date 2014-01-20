//
//  RSLocationManager.h
//  ImVIP
//
//  Created by R0CKSTAR on 1/17/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

#import "RSLocationManagerProfile.h"

@interface RSLocationManager : CLLocationManager

- (void)updateProfile:(RSLocationManagerProfile *)profile;

@property (copy, nonatomic) didUpdateLocations locationsUpdater;

@property (copy, nonatomic) didUpdateHeading headingUpdater;

@property (copy, nonatomic) didFailWithError errorHandler;

@property (copy, nonatomic) didFailWithError serviceRestarter;

@end
