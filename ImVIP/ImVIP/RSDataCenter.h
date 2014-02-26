//
//  RSDataCenter.h
//  ImVIP
//
//  Created by R0CKSTAR on 14-2-15.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <BmobSDK/BmobObject.h>

#import <BmobSDK/BmobUser.h>

extern NSString *const RSDataCenterCardsWillArrive;
extern NSString *const RSDataCenterCardsDidArrive;
extern NSString *const RSDataCenterCardDidUpdate;

@interface RSDataCenter : NSObject

+ (instancetype)defaultCenter;

#pragma mark - Register

- (void)registerBmobWithAppKey:(NSString *)appKey;

#pragma mark - Card

- (NSUInteger)numberOfCachedCard;

- (BmobObject *)getCachedCardAtIndex:(NSInteger)index;

- (void)getCardsAsyncWithCallback:(void(^)(NSArray *))callback
                 whetherNeedQuery:(BOOL)needQuery;

- (void)saveCardWithCardInfo:(NSDictionary *)cardInfo
                withCallback:(void(^)(BOOL, NSError *))callback;

- (void)updateCardAtIndex:(NSInteger)index
             withCallback:(void(^)(BOOL, NSError *))callback;

- (void)deleteCardAtIndex:(NSInteger)index
             withCallback:(void(^)(BOOL, NSError *))callback;

#pragma mark - Achievement

- (BmobObject *)getCachedAchievement;

- (void)getAchievementAsyncWithCallback:(void(^)(BmobObject *))callback;

- (void)saveAchievement:(NSDictionary *)info
           withCallback:(void(^)(BOOL, NSError *))callback;

#pragma mark - User

- (BmobUser *)getUser;

- (void)signUpWithUserInfo:(NSDictionary *)userInfo
              withCallback:(void(^)(BOOL, NSError *))callback;

- (void)signInWithUserInfo:(NSDictionary *)userInfo
              withCallback:(void(^)(BmobUser *, NSError *))callback;

- (void)resetPasswordWithUserInfo:(NSDictionary *)userInfo;

- (void)signOut;

#pragma mark - Statistic

- (NSArray *)getCardOpenLogs;

- (void)logCardOpen;

@end
