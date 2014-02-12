//
//  RSCardsViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 14-1-25.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import "RSCardsViewController.h"

@interface RSCardsViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation RSCardsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:empty_string style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.imageView.image = [UIImage imageNamed:@"icon"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewCard"]) {
        NSLog(@"%@", segue);
    } else if ([segue.identifier isEqualToString:@"OpenCard"]) {
        NSLog(@"%@", segue);
    }
}

@end
