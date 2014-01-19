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

- (void)setProfile:(RSLocationManagerProfile *)profile
{
    _profile = profile;
}

/*
 *  locationManager:didUpdateLocations:
 *
 *  Discussion:
 *    Invoked when new locations are available.  Required for delivery of
 *    deferred locations.  If implemented, updates will
 *    not be delivered to locationManager:didUpdateToLocation:fromLocation:
 *
 *    locations is an array of CLLocation objects in chronological order.
 */
+ (void)locationManager:(RSLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations
{
    int a = 0;
    a++;
}

/*
 *  locationManager:didUpdateHeading:
 *  
 *  Discussion:
 *    Invoked when a new heading is available.
 */
+ (void)locationManager:(RSLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading
{
    
}

/*
 *  locationManagerShouldDisplayHeadingCalibration:
 *
 *  Discussion:
 *    Invoked when a new heading is available. Return YES to display heading calibration info. The display 
 *    will remain until heading is calibrated, unless dismissed early via dismissHeadingCalibrationDisplay.
 */
+ (BOOL)locationManagerShouldDisplayHeadingCalibration:(RSLocationManager *)manager
{
    return YES;
}

/*
 *  locationManager:didDetermineState:forRegion:
 *
 *  Discussion:
 *    Invoked when there's a state transition for a monitored region or in response to a request for state via a
 *    a call to requestStateForRegion:.
 */
+ (void)locationManager:(RSLocationManager *)manager
      didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    
}

/*
 *  locationManager:didRangeBeacons:inRegion:
 *
 *  Discussion:
 *    Invoked when a new set of beacons are available in the specified region.
 *    beacons is an array of CLBeacon objects.
 *    If beacons is empty, it may be assumed no beacons that match the specified region are nearby.
 *    Similarly if a specific beacon no longer appears in beacons, it may be assumed the beacon is no longer received
 *    by the device.
 */
+ (void)locationManager:(RSLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    
}

/*
 *  locationManager:rangingBeaconsDidFailForRegion:withError:
 *
 *  Discussion:
 *    Invoked when an error has occurred ranging beacons in a region. Error types are defined in "CLError.h".
 */
+ (void)locationManager:(RSLocationManager *)manager
rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region
{
    
}

/*
 *  locationManager:didEnterRegion:
 *
 *  Discussion:
 *    Invoked when the user enters a monitored region.  This callback will be invoked for every allocated
 *    RSLocationManager instance with a non-nil delegate that implements this method.
 */
+ (void)locationManager:(RSLocationManager *)manager
         didEnterRegion:(CLRegion *)region
{
    
}

/*
 *  locationManager:didExitRegion:
 *
 *  Discussion:
 *    Invoked when the user exits a monitored region.  This callback will be invoked for every allocated
 *    RSLocationManager instance with a non-nil delegate that implements this method.
 */
+ (void)locationManager:(RSLocationManager *)manager
          didExitRegion:(CLRegion *)region
{
    
}

/*
 *  locationManager:didFailWithError:
 *  
 *  Discussion:
 *    Invoked when an error has occurred. Error types are defined in "CLError.h".
 */
+ (void)locationManager:(RSLocationManager *)manager
       didFailWithError:(NSError *)error
{
    
}

/*
 *  locationManager:monitoringDidFailForRegion:withError:
 *  
 *  Discussion:
 *    Invoked when a region monitoring error has occurred. Error types are defined in "CLError.h".
 */
+ (void)locationManager:(RSLocationManager *)manager
monitoringDidFailForRegion:(CLRegion *)region
              withError:(NSError *)error
{
    
}

/*
 *  locationManager:didChangeAuthorizationStatus:
 *  
 *  Discussion:
 *    Invoked when the authorization status changes for this application.
 */
+ (void)locationManager:(RSLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
}

/*
 *  locationManager:didStartMonitoringForRegion:
 *  
 *  Discussion:
 *    Invoked when a monitoring for a region started successfully.
 */
+ (void)locationManager:(RSLocationManager *)manager
didStartMonitoringForRegion:(CLRegion *)region
{
    
}

/*
 *  Discussion:
 *    Invoked when location updates are automatically paused.
 */
+ (void)locationManagerDidPauseLocationUpdates:(RSLocationManager *)manager
{
    
}

/*
 *  Discussion:
 *    Invoked when location updates are automatically resumed.
 *
 *    In the event that your application is terminated while suspended, you will
 *	  not receive this notification.
 */
+ (void)locationManagerDidResumeLocationUpdates:(RSLocationManager *)manager
{
    
}

/*
 *  locationManager:didFinishDeferredUpdatesWithError:
 *
 *  Discussion:
 *    Invoked when deferred updates will no longer be delivered. Stopping
 *    location, disallowing deferred updates, and meeting a specified criterion
 *    are all possible reasons for finishing deferred updates.
 *
 *    An error will be returned if deferred updates end before the specified
 *    criteria are met (see CLError).
 */
+ (void)locationManager:(RSLocationManager *)manager
didFinishDeferredUpdatesWithError:(NSError *)error
{
    
}

@end
