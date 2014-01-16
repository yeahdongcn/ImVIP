//
//  RSCardView.m
//  ImVIP
//
//  Created by R0CKSTAR on 1/16/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSCardView.h"

@interface RSCardView ()

@property (nonatomic, weak) IBOutlet UIView *tabView;

@property (nonatomic, weak) IBOutlet UIView *contentView;

@property (nonatomic, weak) IBOutlet UIImageView *iconView;

@end

@implementation RSCardView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tabView.layer.cornerRadius = 5;
            self.contentView.layer.cornerRadius = 5;
            self.contentView.layer.borderWidth = 5;
            
            self.contentView.backgroundColor = [UIColor whiteColor];
        });
    }
    return self;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = [borderColor copy];
    
    self.tabView.backgroundColor = _borderColor;
    self.contentView.layer.borderColor = [_borderColor CGColor];
}

@end