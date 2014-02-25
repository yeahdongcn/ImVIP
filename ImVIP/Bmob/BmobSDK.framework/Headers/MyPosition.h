//
//  MyPosition.h
//  BmobSDK
//
//  Created by donson on 13-8-12.
//  Copyright (c) 2013年 donson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MyPosition : NSObject<CLLocationManagerDelegate>{
    

}

-(CLLocationCoordinate2D)getLocation;

@property(nonatomic,assign)double myLatitude;
@property(nonatomic,assign)double myLongitude;
@property(nonatomic,retain)CLLocationManager *locationManager;


+(MyPosition*)sharePosition;

@end
