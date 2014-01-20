//
//  RSLocationManagerProfile.h
//  ImVIP
//
//  Created by R0CKSTAR on 14-1-19.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

typedef void (^didUpdateLocations)(NSArray *);
typedef void (^didUpdateHeading)(CLHeading *);

@interface RSLocationManagerProfile : NSObject

@property (copy, nonatomic) didUpdateLocations locationsUpdater;

@property (copy, nonatomic) didUpdateHeading headingUpdater;

/*
 *  distanceFilter
 *
 *  Discussion:
 *      Specifies the minimum update distance in meters. Client will not be notified of movements of less
 *      than the stated value, unless the accuracy has improved. Pass in kCLDistanceFilterNone to be
 *      notified of all movements. By default, kCLDistanceFilterNone is used.
 */
@property (assign, nonatomic) CLLocationDistance distanceFilter;

/*
 *  desiredAccuracy
 *
 *  Discussion:
 *      The desired location accuracy. The location service will try its best to achieve
 *      your desired accuracy. However, it is not guaranteed. To optimize
 *      power performance, be sure to specify an appropriate accuracy for your usage scenario (eg,
 *      use a large accuracy value when only a coarse location is needed). Use kCLLocationAccuracyBest to
 *      achieve the best possible accuracy. Use kCLLocationAccuracyBestForNavigation for navigation.
 *      By default, kCLLocationAccuracyBest is used.
 */
@property (assign, nonatomic) CLLocationAccuracy desiredAccuracy;

@end
