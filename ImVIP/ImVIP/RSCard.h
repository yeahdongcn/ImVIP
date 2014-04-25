//
//  RSCard.h
//  ImVIP
//
//  Created by R0CKSTAR on 4/11/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface RSCard : AVObject <AVSubclassing, NSCopying>

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *color;

@property (nonatomic) NSUInteger numberOfLikes;

@property (nonatomic) NSUInteger numberOfUses;

@property (nonatomic, strong) RSCard *source;

- (void)forksAsyncWithCallback:(void(^)(NSArray *))callback;

- (void)likeAsyncWithCallback:(void(^)(BOOL))callback;

- (RSCard *)fork;

- (void)use;

+ (void)myCardsWithCallback:(void(^)(NSArray *))callback;

+ (void)top20CardsWithCallback:(void(^)(NSArray *))callback;

+ (void)likedCardsWithCallback:(void(^)(NSArray *))callback;

@end
