//
//  RSCardCell.m
//  ImVIP
//
//  Created by R0CKSTAR on 1/26/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSCardCell.h"

new_class(RSCardCellTitleLabel, UILabel)

new_class(RSCardCellSubtitleLabel, UILabel)

new_class(RSCardCellBgView, UIView)

new_class(RSCardCellButton, UIButton)

@interface RSCardCell ()

@property (nonatomic, strong) UIImage *accessoryViewNormalImage;

@property (nonatomic, strong) UIImage *accessoryViewHighlightedImage;

@end

@implementation RSCardCell

- (void)__updateAccessoryView:(BOOL)highlighted
{
    if (self.accessoryViewNormalImage && self.accessoryViewHighlightedImage) {
        RSCardCellButton *accessoryView = (RSCardCellButton *)self.accessoryView;
        if (highlighted) {
            [accessoryView setImage:self.accessoryViewHighlightedImage forState:UIControlStateNormal];
        } else {
            [accessoryView setImage:self.accessoryViewNormalImage forState:UIControlStateNormal];
        }
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        RSCardCellButton *accessoryView = [RSCardCellButton buttonWithType:UIButtonTypeCustom];
        [accessoryView sizeToFit];
        self.accessoryView = accessoryView;
        
        RSCardCellBgView *selectedBackgroundView = [[RSCardCellBgView alloc] init];
        self.selectedBackgroundView = selectedBackgroundView;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.accessoryViewNormalImage = [accessoryView imageForState:UIControlStateNormal];
            self.accessoryViewHighlightedImage = [accessoryView imageForState:UIControlStateHighlighted];
            [accessoryView setImage:nil forState:UIControlStateHighlighted];
        });
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    [self __updateAccessoryView:highlighted];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    [self __updateAccessoryView:selected];
}

@end
