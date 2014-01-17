//
//  RSLocationManager.m
//  ImVIP
//
//  Created by R0CKSTAR on 1/17/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSLocationManager.h"

@interface RSLocationManager () <CLLocationManagerDelegate>

@end

@implementation RSLocationManager

+ (instancetype)manager
{
    static RSLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        manager.delegate = (id<CLLocationManagerDelegate>)self;
    });
    return manager;
}

+ (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations
{
    int a = 0;
    a++;
}

+ (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading
{
    
}

+ (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager
{
    return YES;
}

+ (void)locationManager:(CLLocationManager *)manager
      didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    
}

+ (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    
}

+ (void)locationManager:(CLLocationManager *)manager
rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region
{
    
}

+ (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region
{
    
}

+ (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region
{
    
}

+ (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    
}

+ (void)locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(CLRegion *)region
              withError:(NSError *)error
{
    
}

+ (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
}


+ (void)locationManager:(CLLocationManager *)manager
didStartMonitoringForRegion:(CLRegion *)region
{
    
}

+ (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager
{
    
}

+ (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager
{
    
}

+ (void)locationManager:(CLLocationManager *)manager
didFinishDeferredUpdatesWithError:(NSError *)error
{
    
}

@end
