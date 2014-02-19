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

@interface RSDataCenter : NSObject

+ (instancetype)defaultCenter;

@property (nonatomic, readonly) NSArray *cards;

- (void)getCardsAsyncWithCallback:(void(^)(NSArray *))callback
                 whetherNeedQuery:(BOOL)needQuery;

- (BmobObject *)getCachedCardAtIndex:(NSInteger)index;

- (void)saveCard:(NSDictionary *)info
    withCallback:(void(^)(BOOL, NSError *))callback;

- (void)getAchievementAsyncWithCallback:(void(^)(BmobObject *))callback;

- (void)saveAchievement:(NSDictionary *)info
           withCallback:(void(^)(BOOL, NSError *))callback;

@end
