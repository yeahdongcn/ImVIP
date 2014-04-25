//
//  main.m
//  ImVIP
//
//  Created by R0CKSTAR on 1/16/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSAppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        [RSCard registerSubclass];
        [RSUser registerSubclass];
        [RSAchievement registerSubclass];
        
        [AVOSCloud setApplicationId:@"os0phxc59j65vn1hz7mit2yjg8bvpinq5cunevsvt2lk3ch0" clientKey:@"fuaywjfd72xf6y2tuwraxt0fwrpv2kgfrhy547h0hpmwv9s3"];
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([RSAppDelegate class]));
    }
}
