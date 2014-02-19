//
//  RSPOIView.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/19/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSPOIView.h"

#import <objc/runtime.h>

@implementation RSPOIView

- (void)__call
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [self.phoneButton titleForState:UIControlStateNormal]]]];
}

- (void)__clicked
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[self.phoneButton titleForState:UIControlStateNormal]
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:RSLocalizedString(@"Cancel")
                                              otherButtonTitles:RSLocalizedString(@"Call"), nil];
    
    void (^handler)(NSInteger) = ^(NSInteger buttonIndex) {
        if (buttonIndex == alertView.cancelButtonIndex) {
        } else {
            [self __call];
        }
    };
    objc_setAssociatedObject(alertView, @"alert", handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [alertView show];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.phoneButton addTarget:self action:@selector(__clicked) forControlEvents:UIControlEventTouchUpInside];
        });
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void (^handler)(NSInteger) = objc_getAssociatedObject(alertView, @"alert");
    handler(buttonIndex);
}

@end
