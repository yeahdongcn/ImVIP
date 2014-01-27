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
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.showIndicator) {
                return;
            }
            self.showIndicator = NO;
        });
    }
    return self;
}

- (void)setShowIndicator:(BOOL)showIndicator
{
    _showIndicator = showIndicator;
    self.indicator.hidden = !showIndicator;
}

@end
