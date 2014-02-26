//
//  RSPOIView.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/19/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSPOIView.h"

#import <objc/runtime.h>

#import <SIAlertView.h>

@implementation RSPOIView

- (void)__call
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [self.phoneButton titleForState:UIControlStateNormal]]]];
}

- (void)__clicked:(id)sender
{
    if (sender == self.phoneButton) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:[self.phoneButton titleForState:UIControlStateNormal] andMessage:nil];
        
        [alertView addButtonWithTitle:RSLocalizedString(@"Cancel")
                                 type:SIAlertViewButtonTypeCancel
                              handler:nil];
        [alertView addButtonWithTitle:RSLocalizedString(@"Call")
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  [self __call];
                              }];
        
        alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromBottom;
        
        [alertView show];
    } else if (sender == self.closeButton) {
        [UIView animateWithDuration:0.3f animations:^{
            CGRect frame = self.frame;
            frame.origin.y += self.bounds.size.height;
            self.frame = frame;
        }];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.phoneButton addTarget:self action:@selector(__clicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.closeButton addTarget:self action:@selector(__clicked:) forControlEvents:UIControlEventTouchUpInside];
        });
    }
    return self;
}

@end
