//
//  RSCardsViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 14-1-25.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import "RSCardsViewController.h"

#import <BmobSDK/BmobQuery.h>

#import <BmobSDK/BmobObject.h>

@interface RSCardsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, copy) NSArray *cards;

@end

@implementation RSCardsViewController

- (void)__refresh
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BmobQuery *query = [BmobQuery queryWithClassName:@"Card"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *cards, NSError *error) {
            self.cards = cards;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.refreshControl endRefreshing];
                
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
            });
        }];
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:empty_string style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(__refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [self __refresh];
    [self.refreshControl beginRefreshing];
    [UIView animateWithDuration:.3 animations:^{
        self.tableView.contentOffset = CGPointMake(0, -self.refreshControl.frame.size.height);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cards count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    BmobObject *card = [self.cards objectAtIndex:[indexPath row]];
    cell.imageView.image = [UIImage imageNamed:@"icon"];
    cell.textLabel.text = [card objectForKey:@"title"];
//    cell.detailTextLabel.text = [card objectForKey:@"subtitle"];
    cell.detailTextLabel.text = [card objectForKey:@"updatedAt"];
    
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
