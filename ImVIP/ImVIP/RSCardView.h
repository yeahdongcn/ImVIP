//
//  RSCardView.h
//  ImVIP
//
//  Created by R0CKSTAR on 2/20/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSCardView : UIView

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UILabel *codeLabel;

@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;

@property (nonatomic, weak) IBOutlet UIImageView *iconView;

@property (nonatomic, weak) IBOutlet UIImageView *codeView;

@end
