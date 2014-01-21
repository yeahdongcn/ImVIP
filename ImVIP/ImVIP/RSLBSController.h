//
//  RSLocationManagerController.h
//  ImVIP
//
//  Created by R0CKSTAR on 1/20/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RSLocationManager.h"

NSString *const RSLBSControllerStartUpdatingLocationNotification;
NSString *const RSLBSControllerStartUpdatingHeadingNotification;

@interface RSLBSController : NSObject

+ (instancetype)controller;

@property (nonatomic, readonly) RSLocationManager *locationManager;

@end