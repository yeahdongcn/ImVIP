//
//  RSProfileViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 14-1-24.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import "RSProfileViewController.h"

#import "RSAchievementCell.h"

#import <ColorUtils.h>

new_class(RSProfileViewTopBanner, UIImageView)

new_class(RSProfileViewBottomBanner, UIImageView)

new_class(RSProfileViewAvatarButton, UIButton)

new_class(RSProfileViewSettingsButton, UIButton)

new_class(RSProfileViewUserLabel, UILabel)

@interface RSProfileViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *background;

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

- (IBAction)__onSettingsClicked
{
    NSLog(@"settings");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.backgroundFrame = self.background.frame;
    
    self.username.text = @"Guest";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RSAchievementCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BmobObject *achievement = [DataCenter getCachedAchievement];
    if (achievement) {
        return [[achievement objectForKey:@"index"] unsignedIntegerValue] + 1;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RSAchievementCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSInteger index = [indexPath row];
    cell.titleLabel.text = [Achievements titleAtIndex:index];
    cell.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", index]];

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
