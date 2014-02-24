//
//  RSCardView.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/20/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSCardView.h"

@implementation RSCardView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addObserver:self forKeyPath:@"codeLabel" options:NSKeyValueObservingOptionInitial context:NULL];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"codeLabel"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"codeLabel"]) {
        self.codeLabel.font = [UIFont fontWithName:@"Farrington-7B-Qiqi" size:16];
    }
}

@end
