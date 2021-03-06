//
//  RSAchievementCell.h
//  ImVIP
//
//  Created by R0CKSTAR on 2/25/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSAchievementCellBgView;

@interface RSAchievementCell : UITableViewCell

@property (nonatomic, weak) IBOutlet RSAchievementCellBgView *bgView;

@property (nonatomic, weak) IBOutlet UIImageView *iconView;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;

@end
