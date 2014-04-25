//
//  RSCard.m
//  ImVIP
//
//  Created by R0CKSTAR on 4/11/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSCard.h"

#define PROPERTY_NAME(property) [[(@""#property) componentsSeparatedByString:@"."] lastObject]

@interface RSCard ()

@end

@implementation RSCard

@dynamic title, code, type, color, source, numberOfLikes, numberOfUses;

+ (NSString *)parseClassName
{
    return @"Card";
}

+ (id)new
{
    RSCard *new = [[[self class] alloc] init];
    new.source = nil;
    new.numberOfLikes = 0;
    new.numberOfUses = 0;
    return new;
}

- (id)copyWithZone:(NSZone *)zone
{
    RSCard *copy = [[[self class] allocWithZone:zone] init];
    copy.title = self.title;
    copy.type = self.type;
    copy.color = self.color;
    copy.code = @"";
    copy.numberOfUses = 0;
    copy.numberOfLikes = 0;
    return copy;
}

- (void)forksAsyncWithCallback:(void(^)(NSArray *))callback
{
    AVQuery *query = [[self class] query];
    [query whereKey:PROPERTY_NAME(self.source) equalTo:self];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects && callback) {
                callback(objects);
            }
        }
    }];
}

- (RSCard *)fork
{
    RSCard *forkedCard = [self copy];
    forkedCard.source = self;
    return forkedCard;
}

- (void)likeAsyncWithCallback:(void(^)(BOOL))callback
{
    RSUser *currentUser = [RSUser currentUser];
    AVRelation *likes = [currentUser relationforKey:@"likes"];
    AVQuery *query = [likes query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        __block BOOL liked = NO;
        if (!error) {
            for (RSCard *card in objects) {
                if ([[card objectId] isEqualToString:[self objectId]]) {
                    liked = YES;
                    break;
                }
            }
        } else {
            liked = YES;
        }
        
        if (liked) {
            [self incrementKey:PROPERTY_NAME(self.numberOfLikes) byAmount:@(-1)];
            [likes removeObject:self];
        } else {
            [self incrementKey:PROPERTY_NAME(self.numberOfLikes)];
            [likes addObject:self];
        }
        [self saveEventually];
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded && callback) {
                callback(liked);
            }
        }];
    }];
}

- (void)use
{
    [self incrementKey:PROPERTY_NAME(self.numberOfUses)];
    [self saveEventually];
}

+ (void)myCardsWithCallback:(void(^)(NSArray *))callback
{
    RSUser *currentUser = [RSUser currentUser];
    AVRelation *cards = [currentUser relationforKey:@"cards"];
    AVQuery *query = [cards query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (callback) {
            callback(objects);
        }
    }];
}

+ (void)top20CardsWithCallback:(void(^)(NSArray *))callback
{
    
}

+ (void)likedCardsWithCallback:(void(^)(NSArray *))callback
{
    
}

@end
