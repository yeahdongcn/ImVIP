//
//  RSDataCenter.h
//  ImVIP
//
//  Created by R0CKSTAR on 14-2-15.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <BmobSDK/BmobObject.h>

extern NSString *const RSDataCenterCardsWillArrive;
extern NSString *const RSDataCenterCardsDidArrive;
extern NSString *const RSDataCenterCardDidUpdate;

@interface RSDataCenter : NSObject

+ (instancetype)defaultCenter;

- (void)getCardsAsyncWithCallback:(void(^)(NSArray *))callback
                 whetherNeedQuery:(BOOL)needQuery;

- (BmobObject *)getCachedCardAtIndex:(NSInteger)index;

- (NSUInteger)numberOfCachedCard;

- (void)saveCardWithCardInfo:(NSDictionary *)cardInfo
                withCallback:(void(^)(BOOL, NSError *))callback;

- (void)updateCardAtIndex:(NSInteger)index
             withCallback:(void(^)(BOOL, NSError *))callback;

- (void)deleteCardAtIndex:(NSInteger)index
             withCallback:(void(^)(BOOL, NSError *))callback;

- (void)getAchievementAsyncWithCallback:(void(^)(BmobObject *))callback;

- (void)saveAchievement:(NSDictionary *)info
           withCallback:(void(^)(BOOL, NSError *))callback;

- (void)signUp;

- (void)signIn;

@end
