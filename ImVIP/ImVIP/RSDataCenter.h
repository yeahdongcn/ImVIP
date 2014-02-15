//
//  RSDataCenter.h
//  ImVIP
//
//  Created by R0CKSTAR on 14-2-15.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <BmobSDK/BmobObject.h>

@interface RSDataCenter : NSObject

+ (instancetype)defaultCenter;

@property (nonatomic, readonly) NSArray *cards;

- (void)queryCards:(BOOL)needQuery withCallback:(void(^)(NSArray *))callback;

- (BmobObject *)cardAtIndex:(NSInteger)index;

- (void)saveCard:(NSDictionary *)info withCallback:(void(^)(BOOL, NSError *))callback;

@end
