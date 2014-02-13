//
//  RSAppDelegate.h
//  ImVIP
//
//  Created by R0CKSTAR on 1/16/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MSDynamicsDrawerViewController.h>

@interface RSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;

@end
