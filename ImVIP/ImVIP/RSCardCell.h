//
//  RSCardCell.h
//  ImVIP
//
//  Created by R0CKSTAR on 1/26/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSCardCellBorderView.h"

@class RSCardCellTagLabel;

@interface RSCardCell : UITableViewCell

@property (nonatomic, strong) RSCardCellBorderView *borderView;

@property (nonatomic, weak) IBOutlet RSCardCellTagLabel *tagLabel;

@end