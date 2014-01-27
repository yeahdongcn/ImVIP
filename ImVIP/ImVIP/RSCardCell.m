//
//  RSCardCell.m
//  ImVIP
//
//  Created by R0CKSTAR on 1/26/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSCardCell.h"

@interface RSCardCellTitleLabel : UILabel
@end

@interface RSCardCellSubtitleLabel : UILabel
@end

@implementation RSCardCellTitleLabel
@end

@implementation RSCardCellSubtitleLabel
@end

@implementation RSCardCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIButton *accessoryView = [UIButton buttonWithType:UIButtonTypeCustom];
        [accessoryView sizeToFit];
        self.accessoryView = accessoryView;
    }
    return self;
}

@end