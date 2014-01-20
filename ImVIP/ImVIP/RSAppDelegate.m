//
//  RSAppDelegate.m
//  ImVIP
//
//  Created by R0CKSTAR on 1/16/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSAppDelegate.h"

#import "MSDynamicsDrawerViewController.h"

#import "RSMenuViewController.h"

#import "UISS.h"

#import "RSLocationManagerController.h"

#import "UIImage+Color.h"

#import "SFUIViewMacroses.h"

@interface RSAppDelegate ()

@property (nonatomic, strong) UISS *uiss;

@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;

@end

@implementation RSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [RSLocationManagerController controller].foregroundProfile = [[RSLocationManagerForegroundProfile alloc] init];
    [RSLocationManagerController controller].backgroundProfile = [[RSLocationManagerBackgroundProfile alloc] init];
    [[NSNotificationCenter defaultCenter] postNotificationName:RSLocationManagerControllerStartUpdatingLocationNotification object:nil];
    
    self.uiss = [UISS configureWithDefaultJSONFile];
    self.uiss.statusWindowEnabled = YES;
    
    self.dynamicsDrawerViewController = (MSDynamicsDrawerViewController *)self.window.rootViewController;
    
    [self.dynamicsDrawerViewController addStylersFromArray:@[[MSDynamicsDrawerScaleStyler styler], [MSDynamicsDrawerFadeStyler styler]] forDirection:MSDynamicsDrawerDirectionLeft];
    
    RSMenuViewController *menuViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    menuViewController.dynamicsDrawerViewController = self.dynamicsDrawerViewController;
    [self.dynamicsDrawerViewController setDrawerViewController:menuViewController forDirection:MSDynamicsDrawerDirectionLeft];
    
    self.dynamicsDrawerViewController.paneViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Root"];
    
    int hexValue = 0x24212f;
    CGFloat red = ((hexValue & 0xFF0000) >> 16) / 255.0f;
    CGFloat green = ((hexValue & 0x00FF00) >> 8) / 255.0f;
    CGFloat blue = (hexValue & 0x0000FF) / 255.0f;
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.window.bounds];
    backgroundView.image = [UIImage imageWithColor:[UIColor colorWithRed:red green:green blue:blue alpha:1]];
    backgroundView.autoresizingMask = UIViewAutoresizingMake(@"W+H");
    [self.window insertSubview:backgroundView atIndex:0];

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
