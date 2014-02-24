//
//  RSMenuCell.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/11/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSMenuCell.h"

new_class(RSMenuCellSelectedBackgroundView, UIView)

@implementation RSMenuCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        RSMenuCellSelectedBackgroundView *selectedBackgroundView = [RSMenuCellSelectedBackgroundView new];
        self.selectedBackgroundView = selectedBackgroundView;
        
        [self addObserver:self forKeyPath:@"textLabel" options:NSKeyValueObservingOptionInitial context:NULL];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"textLabel"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"textLabel"]) {
        self.textLabel.font = [UIFont fontWithName:@"FZQingKeBenYueSongS-R-GB" size:18];
    }
}

@end
