//
//  RSTitleView.m
//  ImVIP
//
//  Created by R0CKSTAR on 1/27/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSTitleView.h"

@interface RSTitleView ()

@property (nonatomic, weak) IBOutlet UIImageView *indicator;

@end

@implementation RSTitleView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addObserver:self forKeyPath:@"label" options:NSKeyValueObservingOptionInitial context:NULL];
        [self addObserver:self forKeyPath:@"indicator" options:NSKeyValueObservingOptionInitial context:NULL];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"label"];
    [self removeObserver:self forKeyPath:@"indicator"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"label"]) {
        self.label.font = [UIFont fontWithName:@"FZQingKeBenYueSongS-R-GB" size:18];
    } else if ([keyPath isEqualToString:@"indicator"]) {
        if (self.showIndicator) {
            return;
        }
        self.showIndicator = NO;
    }
}

- (void)setShowIndicator:(BOOL)showIndicator
{
    _showIndicator = showIndicator;
    self.indicator.hidden = !showIndicator;
}

@end
