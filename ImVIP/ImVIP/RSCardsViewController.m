//
//  RSCardsViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 14-1-25.
//  Copyright (c) 2014年 P.D.Q. All rights reserved.
//

#import "RSCardsViewController.h"

@interface RSCardsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic) BOOL needReload;

@property (nonatomic) BOOL isViewAppear;

@end

@implementation RSCardsViewController

- (void)__refresh
{
    [DataCenter queryCardsNeedRefresh:YES withCallback:^(NSArray *cards) {
        [self.refreshControl endRefreshing];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (void)__fakeRefresh
{
    self.needReload = NO;
    
    [self.refreshControl beginRefreshing];
    [UIView animateWithDuration:.3 animations:^{
        self.tableView.contentOffset = CGPointMake(0, self.tableView.contentOffset.y - self.refreshControl.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.3 animations:^{
            // Wait .3
        } completion:^(BOOL finished) {
            [self.refreshControl endRefreshing];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
    }];
}

- (void)__cardsWillArrive:(NSNotification *)notification
{
    // Nothing to do currently
}

- (void)__cardsDidArrive:(NSNotification *)notification
{
    if (self.isViewAppear) {
        [self __fakeRefresh];
    } else {
        self.needReload = YES;
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__cardsWillArrive:) name:RSDataCenterCardsWillArrive object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__cardsDidArrive:) name:RSDataCenterCardsDidArrive object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        self.tableView.contentOffset = CGPointMake(0, self.tableView.contentOffset.y - self.refreshControl.frame.size.height);
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.isViewAppear = YES;
    
    if (self.needReload) {
        [self __fakeRefresh];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.isViewAppear = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DataCenter.cards count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    BmobObject *card = [DataCenter cardAtIndex:[indexPath row]];
    cell.imageView.image = [UIImage imageNamed:@"icon"];
    cell.textLabel.text = [card objectForKey:@"title"];
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
