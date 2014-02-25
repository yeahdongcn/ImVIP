//
//  RSDataCenter.m
//  ImVIP
//
//  Created by R0CKSTAR on 14-2-15.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import "RSDataCenter.h"

#import <BmobSDK/Bmob.h>

#import <BmobSDK/BmobQuery.h>

NSString *const RSDataCenterCardsWillArrive = @"com.pdq.imvip.datacenter.cardsWillArrive";
NSString *const RSDataCenterCardsDidArrive  = @"com.pdq.imvip.datacenter.cardsDidArrive";
NSString *const RSDataCenterCardDidUpdate   = @"com.pdq.imvip.datacenter.cardDidUpdate";

@interface RSDataCenter ()

@property (nonatomic, strong) NSArray *cachedCards;

@end

@implementation RSDataCenter

- (void)registerBmobWithAppKey:(NSString *)appKey
{
    [Bmob registWithAppKey:appKey];
}

+ (instancetype)defaultCenter
{
    static RSDataCenter *defaultCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCenter = [[self alloc] init];
    });
    return defaultCenter;
}

#pragma mark - Card

- (NSUInteger)numberOfCachedCard
{
    return [self.cachedCards count];
}

- (BmobObject *)getCachedCardAtIndex:(NSInteger)index
{
    if (index < 0 || index >= [self numberOfCachedCard]) {
        return nil;
    } else {
        return [self.cachedCards objectAtIndex:index];
    }
}

- (void)getCardsAsyncWithCallback:(void(^)(NSArray *))callback
                 whetherNeedQuery:(BOOL)needQuery
{
    if (needQuery == NO && self.cachedCards && callback) {
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(self.cachedCards);
        });
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            BmobQuery *query = [BmobQuery queryWithClassName:@"Card"];
            [query findObjectsInBackgroundWithBlock:^(NSArray *cards, NSError *error) {
                self.cachedCards = cards;
                if (callback) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        callback(self.cachedCards);
                    });
                }
            }];
        });
    }
}

- (void)saveCardWithCardInfo:(NSDictionary *)cardInfo
                withCallback:(void(^)(BOOL, NSError *))callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BmobObject *card = [[BmobObject alloc] initWithClassName:@"Card"];
        [cardInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [card setObject:obj forKey:key];
        }];
        [card saveInBackgroundWithResultBlock:^(BOOL succeeded, NSError *error) {
            if (callback) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(succeeded, error);
                });
            }
            
            // Update in background
            if (succeeded) {
                // Going to refresh cards in background
                [[NSNotificationCenter defaultCenter] postNotificationName:RSDataCenterCardsWillArrive object:nil];
                
                [self getCardsAsyncWithCallback:^(NSArray *cards) {
                    // Cards ready
                    [[NSNotificationCenter defaultCenter] postNotificationName:RSDataCenterCardsDidArrive object:cards];
                } whetherNeedQuery:YES];
            }
        }];
    });
}

- (void)updateCardAtIndex:(NSInteger)index
             withCallback:(void(^)(BOOL, NSError *))callback
{
    BmobObject *card = [self getCachedCardAtIndex:index];
    [card updateInBackgroundWithResultBlock:^(BOOL succeeded, NSError *error) {
        if (callback) {
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(succeeded, error);
            });
        }
        
        if (succeeded) {
            [[NSNotificationCenter defaultCenter] postNotificationName:RSDataCenterCardDidUpdate object:nil];
        }
    }];
}

- (void)deleteCardAtIndex:(NSInteger)index
             withCallback:(void(^)(BOOL, NSError *))callback
{
    BmobObject *card = [self getCachedCardAtIndex:index];
    [card deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (callback) {
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(succeeded, error);
            });
        }
        
        // Update in background
        if (succeeded) {
            // Going to refresh cards in background
            [[NSNotificationCenter defaultCenter] postNotificationName:RSDataCenterCardsWillArrive object:nil];
            
            [self getCardsAsyncWithCallback:^(NSArray *cards) {
                // Cards ready
                [[NSNotificationCenter defaultCenter] postNotificationName:RSDataCenterCardsDidArrive object:cards];
            } whetherNeedQuery:YES];
        }
    }];
}

#pragma mark - Achievement

- (void)getAchievementAsyncWithCallback:(void(^)(BmobObject *))callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *achievementId = [[NSUserDefaults standardUserDefaults] objectForKey:@"AchievementId"];
        if (achievementId && [achievementId length] > 0) {
            BmobQuery *query = [BmobQuery queryWithClassName:@"Achievement"];
            [query getObjectInBackgroundWithId:achievementId block:^(BmobObject *achievement, NSError *error) {
                if (callback) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        callback(achievement);
                    });
                }
            }];
        }
    });
}

- (void)saveAchievement:(NSDictionary *)info
           withCallback:(void(^)(BOOL, NSError *))callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *achievementId = [[NSUserDefaults standardUserDefaults] objectForKey:@"AchievementId"];
        if (achievementId && [achievementId length] > 0) {
            [self getAchievementAsyncWithCallback:^(BmobObject *achievement) {
                [info enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    [achievement setObject:obj forKey:key];
                }];
                [achievement updateInBackgroundWithResultBlock:^(BOOL succeeded, NSError *error) {
                    if (callback) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            callback(succeeded, error);
                        });
                    }
                }];
            }];
        } else {
            BmobObject *achievement = [[BmobObject alloc] initWithClassName:@"Achievement"];
            [info enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                [achievement setObject:obj forKey:key];
            }];
            [achievement saveInBackgroundWithResultBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [[NSUserDefaults standardUserDefaults] setObject:achievement.objectId forKey:@"AchievementId"];
                }
                if (callback) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        callback(succeeded, error);
                    });
                }
            }];
        }
    });
}

#pragma mark - User

- (BmobUser *)getUser
{
    return [BmobUser getCurrentObject];
}

- (void)signUpWithUserInfo:(NSDictionary *)userInfo
              withCallback:(void(^)(BOOL, NSError *))callback
{
    BmobUser *user = [[BmobUser alloc] init];
    [userInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key isEqualToString:@"username"]) {
            [user setUserName:obj];
        } else if ([key isEqualToString:@"password"]) {
            [user setPassword:obj];
        } else if ([key isEqualToString:@"email"]) {
            [user setEamil:obj];
        } else {
            [user setObject:obj forKey:key];
        }
    }];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (callback) {
            callback(succeeded, error);
        }
    }];
}

- (void)signInWithUserInfo:(NSDictionary *)userInfo
              withCallback:(void(^)(BmobUser *, NSError *))callback
{
    [BmobUser logInWithUsernameInBackground:[userInfo objectForKey:@"username"]
                                   password:[userInfo objectForKey:@"password"]
                                      block:^(BmobUser *user, NSError *error) {
                                          if (callback) {
                                              callback(user, error);
                                          }
                                      }];
}

- (void)resetPasswordWithUserInfo:(NSDictionary *)userInfo
{
    [BmobUser requestPasswordResetInBackgroundWithEmail:[userInfo objectForKey:@"email"]];
}

- (void)signOut
{
    [BmobUser logout];
}

@end
