//
//  RSAchievements.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/18/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSAchievements.h"

#import <CRToast.h>

#import <ColorUtils.h>

@implementation RSAchievements

+ (instancetype)defaultAchievements
{
    static RSAchievements *defaultAchievements = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultAchievements = [[self alloc] init];
    });
    return defaultAchievements;
}

- (NSString *)titleAtIndex:(NSInteger)index
{
    NSString *text = nil;
    switch (index) {
        case 0:
            text = RSLocalizedString(@"FIRST BLOOD");
            break;
        case 1:
            text = RSLocalizedString(@"AND SO IT BEGINS");
            break;
        case 2:
            text = RSLocalizedString(@"CONSTRUCTOR");
            break;
        case 3:
            text = RSLocalizedString(@"ENGINEER");
            break;
        case 4:
            text = RSLocalizedString(@"THE ARCHITECT");
            break;
        case 5:
            text = RSLocalizedString(@"SPECIALIST");
            break;
        case 6:
            text = RSLocalizedString(@"SUPERSTAR");
            break;
        case 7:
            text = RSLocalizedString(@"HOLY SHIT");
            break;
    }
    return text;
}

- (NSInteger)__reIndex:(NSUInteger)aIndex
{
    if (aIndex <= 1) {
        return 0;
    } else if (aIndex <= 2) {
        return 1;
    } else if (aIndex <= 3) {
        return 2;
    } else if (aIndex <= 5) {
        return 3;
    } else if (aIndex <= 8) {
        return 4;
    } else if (aIndex <= 13) {
        return 5;
    } else if (aIndex <= 21) {
        return 6;
    } else {
        return 7;
    }
}

- (void)setNumberOfCards:(NSUInteger)numberOfCards
{
    BmobObject *oldAchievement = [DataCenter getCachedAchievement];
    NSUInteger oldNumberOfCards = [[oldAchievement objectForKey:@"numberOfCards"] unsignedIntegerValue];
    
    if (numberOfCards <= oldNumberOfCards) {
        return;
    }
    
    NSInteger index = [self __reIndex:numberOfCards];
    NSString *text = [self titleAtIndex:index];
    NSMutableDictionary *achievement = [NSMutableDictionary new];
    achievement[@"index"] = @(index);
    achievement[@"numberOfCards"] = @(numberOfCards);
    [DataCenter saveAchievement:achievement withCallback:nil];
    
    if (text) {
        double delayInSeconds = 2;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NSDictionary *options = @{kCRToastNotificationTypeKey             : @(CRToastTypeNavigationBar),
                                      kCRToastNotificationPresentationTypeKey : @(CRToastPresentationTypePush),
                                      kCRToastTextKey                         : text,
                                      kCRToastImageKey                        : [UIImage imageNamed:@"achievements_checkmark"],
                                      kCRToastBackgroundColorKey              : [UIColor colorWithRGBValue:0x00cab5],
                                      kCRToastAnimationInTimeIntervalKey      : @(0.6),
                                      kCRToastTimeIntervalKey                 : @(3.0),
                                      kCRToastAnimationOutTimeIntervalKey     : @(0.6),
                                      kCRToastFontKey                         : [UIFont fontWithName:@"ObelixPro" size:16],
                                      kCRToastTextColorKey                    : [UIColor colorWithRGBValue:0xfafafa],
                                      kCRToastTextAlignmentKey                : @(NSTextAlignmentLeft),
                                      kCRToastAnimationInTypeKey              : @(CRToastAnimationTypeGravity),
                                      kCRToastAnimationOutTypeKey             : @(CRToastAnimationTypeGravity),
                                      kCRToastAnimationInDirectionKey         : @(CRToastAnimationDirectionTop),
                                      kCRToastAnimationOutDirectionKey        : @(CRToastAnimationDirectionTop)};
            
            [CRToastManager showNotificationWithOptions:options
                                        completionBlock:^{
                                            NSLog(@"Completed");
                                        }];
        });
    }
}

@end
