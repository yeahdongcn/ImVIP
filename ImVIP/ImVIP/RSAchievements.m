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

- (void)setNumberOfCards:(NSUInteger)numberOfCards
{
    BmobObject *oldAchievement = [DataCenter getCachedAchievement];
    NSUInteger oldNumberOfCards = [[oldAchievement objectForKey:@"numberOfCards"] unsignedIntegerValue];
    
    if (numberOfCards <= oldNumberOfCards) {
        return;
    }
    
    NSString *text = nil;
    switch (numberOfCards) {
        case 1:
            text = RSLocalizedString(@"FIRST BLOOD");
            break;
        case 2:
            text = RSLocalizedString(@"Double Kill");
            break;
        case 3:
            text = RSLocalizedString(@"Triple Kill");
            break;
        case 5:
            text = RSLocalizedString(@"Killing Spree");
            break;
        case 8:
            text = RSLocalizedString(@"Dominating");
            break;
        case 13:
            text = RSLocalizedString(@"Mega Kill");
            break;
        case 21:
            text = RSLocalizedString(@"Unstoppable");
            break;
        case 34:
            text = RSLocalizedString(@"Wicked Sick");
            break;
        default:
            break;
    }
    
    NSMutableDictionary *achievement = [NSMutableDictionary new];
    [achievement setObject:@(numberOfCards) forKey:@"numberOfCards"];
    [achievement setObject:text ? text : kRSTextDefault forKey:@"text"];
    [DataCenter saveAchievement:achievement withCallback:^(BOOL succeeded, NSError *error) {
        NSLog(@"Save achievement: succeeded = %d, error = %@", succeeded, error);
    }];
    
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
