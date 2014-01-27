//
//  RSProfileViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 14-1-24.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import "RSProfileViewController.h"

@interface RSProfileViewController ()

@end

@implementation RSProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    id a= self.tableView.tableHeaderView;
    NSLog(@"%@", a);
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

@end
