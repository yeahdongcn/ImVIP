//
//  RSCardCellBorderView.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/26/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSCardCellBorderView.h"

@interface RSCardCellBorderView ()

@property (nonatomic, strong) UIBezierPath *border;

@end

@implementation RSCardCellBorderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor= [UIColor clearColor];
        self.border = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(3, 3, self.bounds.size.width - 6, self.bounds.size.height - 1)
                                              byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                    cornerRadii:CGSizeMake(11, 11)];
        self.border.lineWidth = 0.1;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (self.strokeColor) {
        [self.strokeColor setStroke];
    } else {
        [[UIColor blackColor] setStroke];
    }
    
    [self.border stroke];
}

@end
