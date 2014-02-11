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
    }
    return self;
}

@end
