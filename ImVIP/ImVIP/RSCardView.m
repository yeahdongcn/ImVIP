//
//  RSCardView.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/20/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSCardView.h"

@interface RSCardView ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UILabel *codeLabel;

@property (nonatomic, weak) IBOutlet UIImageView *iconView;

@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;

@end

@implementation RSCardView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.titleLabel.font = [UIFont fontWithName:@"FZQingKeBenYueSongS-R-GB" size:18];
            self.codeLabel.font = [UIFont fontWithName:@"Farrington-7B-Qiqi" size:16];
        });
    }
    return self;
}
@end
