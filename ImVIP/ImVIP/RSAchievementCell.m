//
//  RSAchievementCell.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/25/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSAchievementCell.h"

#import <ColorUtils.h>

@implementation RSAchievementCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addObserver:self forKeyPath:@"titleLabel" options:NSKeyValueObservingOptionInitial context:NULL];
                [self addObserver:self forKeyPath:@"subtitleLabel" options:NSKeyValueObservingOptionInitial context:NULL];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"titleLabel"]) {
        self.titleLabel.font = [UIFont fontWithName:@"ObelixPro" size:16];
        self.titleLabel.textColor = [UIColor colorWithRGBValue:0xe7d7b5];
    } else if ([keyPath isEqualToString:@"subtitleLabel"]) {
        self.subtitleLabel.font = [UIFont fontWithName:@"ObelixPro" size:12];
                self.subtitleLabel.textColor = [UIColor colorWithRGBValue:0xceaa7b];
    }
}

@end
