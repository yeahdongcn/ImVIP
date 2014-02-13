//
//  RSAppDelegate.m
//  ImVIP
//
//  Created by R0CKSTAR on 1/16/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSAppDelegate.h"

#import "RSMenuViewController.h"

#import "RSProfileViewController.h"

#import <UISS.h>

#import "SFUIViewMacroses.h"

#import <BmobSDK/Bmob.h>

#import <TestFlight.h>

new_class(RSWindowBackgroundView, UIImageView)

@interface RSAppDelegate ()

@property (nonatomic, strong) UISS *uiss;

@end

@implementation RSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // UISS
    self.uiss = [UISS configureWithDefaultJSONFile];
    self.uiss.statusWindowEnabled = NO;
    
    // Dynamics drawer
    self.dynamicsDrawerViewController = (MSDynamicsDrawerViewController *)self.window.rootViewController;
    MSDynamicsDrawerShadowStyler *shadowStyler = [MSDynamicsDrawerShadowStyler styler];
    shadowStyler.shadowRadius  = 2.0f;
    shadowStyler.shadowOpacity = 0.2f;
    [self.dynamicsDrawerViewController addStylersFromArray:@[
                                                             [MSDynamicsDrawerScaleStyler styler],
                                                             [MSDynamicsDrawerFadeStyler styler],
                                                             shadowStyler
                                                             ]
                                              forDirection:MSDynamicsDrawerDirectionLeft];
    [self.dynamicsDrawerViewController addStylersFromArray:@[
                                                             [MSDynamicsDrawerScaleStyler styler],
                                                             [MSDynamicsDrawerFadeStyler styler],
                                                             shadowStyler
                                                             ]
                                              forDirection:MSDynamicsDrawerDirectionRight];
    
    RSMenuViewController *menuViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    [self.dynamicsDrawerViewController setDrawerViewController:menuViewController forDirection:MSDynamicsDrawerDirectionLeft];
    
    RSProfileViewController *userViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Profile"];
    [self.dynamicsDrawerViewController setDrawerViewController:userViewController forDirection:MSDynamicsDrawerDirectionRight];
    
    // Transition to the first view controller
    [menuViewController transitionToViewController:RSPaneViewControllerTypeCards];

    // Custom background
    RSWindowBackgroundView *backgroundView = [[RSWindowBackgroundView alloc] initWithFrame:self.window.bounds];
    backgroundView.autoresizingMask = UIViewAutoresizingMake(@"W+H");
    [self.window insertSubview:backgroundView atIndex:0];
    
    // Bmob
    [Bmob registWithAppKey:@"7f0528f19873c62d6ffbcfa2f25d1c1c"];
    
    // TestFlight
    [TestFlight takeOff:@"2d88fd65-7bc4-4e45-9dc9-01e9db1c23c5"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
