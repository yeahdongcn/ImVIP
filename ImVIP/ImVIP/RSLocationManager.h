//
//  RSLocationManager.h
//  ImVIP
//
//  Created by R0CKSTAR on 1/17/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

typedef void (^didUpdateLocations)(NSArray *);
typedef void (^didUpdateHeading)(CLHeading *);
typedef void (^didFailWithError)(NSError *);

@interface RSLocationManager : CLLocationManager

@property (copy, nonatomic) didUpdateLocations locationsUpdater;

@property (copy, nonatomic) didUpdateHeading headingUpdater;

@property (copy, nonatomic) didFailWithError errorHandler;

@property (copy, nonatomic) didFailWithError serviceRestarter;

@end
