//
//  RSCardCell.m
//  ImVIP
//
//  Created by R0CKSTAR on 1/26/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSCardCell.h"

#import "ColorUtils.h"

@interface RSCardCellTitleLabel : UILabel
@end

@interface RSCardCellSubtitleLabel : UILabel
@end

@implementation RSCardCellTitleLabel
@end

@implementation RSCardCellSubtitleLabel
@end

@interface RSCardCellBgView : UIView
@end

@implementation RSCardCellBgView
@end

@interface RSCardCellButton : UIButton
@end

@implementation RSCardCellButton
@end

@implementation RSCardCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        RSCardCellButton *accessoryView = [RSCardCellButton buttonWithType:UIButtonTypeSystem];
        [accessoryView sizeToFit];
        self.accessoryView = accessoryView;
        
        RSCardCellBgView *selectedBackgroundView = [[RSCardCellBgView alloc] init];
        self.selectedBackgroundView = selectedBackgroundView;
    }
    return self;
}

@end
