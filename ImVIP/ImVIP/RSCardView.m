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
        [self addObserver:self forKeyPath:@"tagLabel" options:NSKeyValueObservingOptionInitial context:NULL];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"codeLabel"];
    [self removeObserver:self forKeyPath:@"tagLabel"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"codeLabel"]) {
        self.codeLabel.font = [UIFont fontWithName:@"Farrington-7B-Qiqi" size:16];
    } else if ([keyPath isEqualToString:@"tagLabel"]) {
        self.tagLabel.layer.borderColor = [[UIColor blackColor] CGColor];
        self.tagLabel.layer.borderWidth = 0.1f;
        self.tagLabel.layer.cornerRadius = 3.0f;
    }
}

@end
