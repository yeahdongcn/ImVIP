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

new_class(RSCardCellSelectedBackgroundView, UIView)

new_class(RSCardCellAccessoryView, UIButton)

new_class(RSCardCellTagLabel, UILabel)

@interface RSCardCell ()

@property (nonatomic, strong) UIImage *accessoryViewNormalImage;

@property (nonatomic, strong) UIImage *accessoryViewHighlightedImage;

@end

@implementation RSCardCell

- (void)__onAccessoryViewUpdated:(BOOL)highlighted
{
    if (self.accessoryViewNormalImage && self.accessoryViewHighlightedImage) {
        RSCardCellAccessoryView *accessoryView = (RSCardCellAccessoryView *)self.accessoryView;
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
        self.borderView = [[RSCardCellBorderView alloc] initWithFrame:self.bounds];
        [self addSubview:self.borderView];
        
        RSCardCellAccessoryView *accessoryView = [RSCardCellAccessoryView buttonWithType:UIButtonTypeCustom];
        [accessoryView sizeToFit];
        self.accessoryView = accessoryView;
        
        RSCardCellSelectedBackgroundView *selectedBackgroundView = [RSCardCellSelectedBackgroundView new];
        self.selectedBackgroundView = selectedBackgroundView;
        
        [self addObserver:self forKeyPath:@"tagLabel" options:NSKeyValueObservingOptionInitial context:NULL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.accessoryViewNormalImage = [accessoryView imageForState:UIControlStateNormal];
            self.accessoryViewHighlightedImage = [accessoryView imageForState:UIControlStateHighlighted];
            [accessoryView setImage:nil forState:UIControlStateHighlighted];
        });
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"tagLabel"]) {
        self.tagLabel.layer.borderColor = [[UIColor blackColor] CGColor];
        self.tagLabel.layer.borderWidth = 0.1f;
        self.tagLabel.layer.cornerRadius = 3.0f;
    }
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"tagLabel"];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    [self __onAccessoryViewUpdated:highlighted];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    [self __onAccessoryViewUpdated:selected];
}

@end
