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

@property (nonatomic, copy) NSArray *cards;

@end

@implementation RSCardsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        BmobQuery *query = [BmobQuery queryWithClassName:@"Card"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *cards, NSError *error) {
            self.cards = cards;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:empty_string style:UIBarButtonItemStylePlain target:nil action:nil];
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
    cell.detailTextLabel.text = [card objectForKey:@"subtitle"];
    
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
