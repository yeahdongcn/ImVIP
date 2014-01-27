//
//  RSProfileViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 14-1-24.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import "RSProfileViewController.h"

@interface RSProfileViewBgView : UIView
@end

@implementation RSProfileViewBgView
@end

@interface RSProfileViewAvatarView : UIView
@end

@implementation RSProfileViewAvatarView
@end

@interface RSProfileViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *bg;

@property (nonatomic) CGRect bgFrame;

- (IBAction)avatarClicked:(id)sender;

- (IBAction)bgClicked:(id)sender;

@end

@implementation RSProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bgFrame = self.bg.frame;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < 0) {
        CGRect frame = self.bgFrame;
        frame.origin.y += yOffset;
        frame.size.height -= yOffset;
        self.bg.frame = frame;
    } else if (!CGRectEqualToRect(self.bg.frame, self.bgFrame)){
        self.bg.frame = self.bgFrame;
    }
}

- (IBAction)avatarClicked:(id)sender
{
    NSLog(@"avatar");
}

- (IBAction)bgClicked:(id)sender
{
    NSLog(@"bg");
}

@end
