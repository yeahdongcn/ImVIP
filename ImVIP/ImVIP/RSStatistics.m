//
//  RSStatistics.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/19/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSStatistics.h"

@implementation RSStatistics

+ (instancetype)defaultStatistics
{
    static RSStatistics *defaultStatistics = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultStatistics = [[self alloc] init];
    });
    return defaultStatistics;
}

@end
