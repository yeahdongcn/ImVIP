//
//  RSSalesViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/14/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSSalesViewController.h"

@interface RSSalesViewController ()

@end

@implementation RSSalesViewController

- (void)__refresh
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
        });
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.refreshControl addTarget:self action:@selector(__refresh) forControlEvents:UIControlEventValueChanged];
    
    [self __refresh];
    [self.refreshControl beginRefreshing];
    [UIView animateWithDuration:.3 animations:^{
        self.tableView.contentOffset = CGPointMake(0, -self.refreshControl.frame.size.height);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
