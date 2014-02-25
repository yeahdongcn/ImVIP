//
//  RSProfileViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 14-1-24.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import "RSProfileViewController.h"

#import "RSAchievementCell.h"

new_class(RSProfileViewBackgroundView, UIView)

new_class(RSProfileViewAvatarView, UIView)

new_class(RSProfileViewMoreButton, UIButton)

@interface RSProfileViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *background;

@property (nonatomic, weak) IBOutlet UIButton *avatar;

@property (nonatomic, weak) IBOutlet UILabel *username;

@property (nonatomic) CGRect backgroundFrame;

@end

@implementation RSProfileViewController

- (IBAction)__onAvatarClicked
{
    NSLog(@"avatar");
}

- (IBAction)__onBgClicked
{
    NSLog(@"bg");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.backgroundFrame = self.background.frame;
    
    self.username.text = @"Guest";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RSAchievementCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RSAchievementCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.iconView.image = [UIImage imageNamed:@"0"];
    cell.bgView.image = [UIImage imageNamed:@"cell_bg"];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < 0) {
        CGRect frame = self.backgroundFrame;
        frame.origin.y += yOffset;
        frame.size.height -= yOffset;
        self.background.frame = frame;
    } else if (!CGRectEqualToRect(self.background.frame, self.backgroundFrame)){
        self.background.frame = self.backgroundFrame;
    }
}

@end
