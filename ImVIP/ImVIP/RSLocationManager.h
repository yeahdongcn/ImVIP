//
//  RSLocationManager.h
//  ImVIP
//
//  Created by R0CKSTAR on 1/17/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@class RSLocationManagerProfile;

@interface RSLocationManager : CLLocationManager

+ (instancetype)manager;

@property (nonatomic, strong) RSLocationManagerProfile *profile;

@end
