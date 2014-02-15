//
//  RSDataCenter.m
//  ImVIP
//
//  Created by R0CKSTAR on 14-2-15.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import "RSDataCenter.h"

#import <BmobSDK/BmobQuery.h>

@interface RSDataCenter ()

@property (nonatomic, strong) NSArray *cards;

@end

@implementation RSDataCenter

+ (instancetype)defaultCenter
{
    static RSDataCenter *defaultCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCenter = [[self alloc] init];
    });
    return defaultCenter;
}

- (void)queryCards:(BOOL)needQuery withCallback:(void(^)(NSArray *))callback
{
    if (needQuery == NO && self.cards && callback) {
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(self.cards);
        });
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            BmobQuery *query = [BmobQuery queryWithClassName:@"Card"];
            [query findObjectsInBackgroundWithBlock:^(NSArray *cards, NSError *error) {
                self.cards = cards;
                if (callback) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        callback(self.cards);
                    });
                }
            }];
        });
    }
}

- (BmobObject *)cardAtIndex:(NSInteger)index
{
    return [self.cards objectAtIndex:index];
}

- (void)saveCard:(NSDictionary *)info withCallback:(void(^)(BOOL, NSError *))callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BmobObject *card = [[BmobObject alloc] initWithClassName:@"Card"];
        [info enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [card setObject:obj forKey:key];
        }];
        [card saveInBackgroundWithResultBlock:^(BOOL succeeded, NSError *error) {
            if (callback) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(succeeded, error);
                });
            }
        }];
    });
}

@end
