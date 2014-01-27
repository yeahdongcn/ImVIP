//
//  RSCardsViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 14-1-25.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import "RSCardsViewController.h"

@interface RSCardsViewController () <UITableViewDataSource, UITableViewDelegate>

- (IBAction)addNewCard:(id)sender;

@end

@implementation RSCardsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    return cell;
}

- (IBAction)addNewCard:(id)sender
{
    NSLog(@"Add new card.");
}

@end
