//
//  RSLeftViewController.h
//  ImVIP
//
//  Created by R0CKSTAR on 1/16/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RSPaneViewControllerType) {
    RSPaneViewControllerTypeCards,
    RSPaneViewControllerTypeLBS,
//    RSPaneViewControllerTypeSale,
    RSPaneViewControllerTypeBarcodes,
    RSPaneViewControllerTypeStatistics
};

@interface RSMenuViewController : UITableViewController

@property (nonatomic, assign) RSPaneViewControllerType paneViewControllerType;

- (void)transitionToViewController:(RSPaneViewControllerType)paneViewControllerType;

@end
