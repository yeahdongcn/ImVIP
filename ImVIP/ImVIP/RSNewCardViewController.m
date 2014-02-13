//
//  RSNewCardViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/12/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSNewCardViewController.h"

#import "RSTitleView.h"

#import "RSAppDelegate.h"

#import <BmobSDK/BmobObject.h>

#import <AVFoundation/AVFoundation.h>

new_class(RSNewCardLabel, UILabel)

new_class(RSNewCardButton, UIButton)

new_class(RSNewCardTextField, UITextField)

@interface RSNewCardViewController ()

@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;

@property (nonatomic, weak) IBOutlet UITextField *titleField;

@property (nonatomic, weak) IBOutlet UITextField *subtitleField;

@property (nonatomic, weak) IBOutlet UITextField *codeField;

@property (nonatomic, weak) IBOutlet UIView *colorView;

@property (nonatomic, strong) AVMetadataMachineReadableCodeObject *codeObject;

@end

@implementation RSNewCardViewController

- (IBAction)__openImage:(id)sender
{
    
}

- (IBAction)__openCamera:(id)sender
{
    
}

- (IBAction)__saveCard:(id)sender
{
    
}

- (IBAction)__scanCode:(id)sender
{
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dynamicsDrawerViewController = ((RSAppDelegate *)[[UIApplication sharedApplication] delegate]).dynamicsDrawerViewController;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.dynamicsDrawerViewController setPaneDragRevealEnabled:NO forDirection:MSDynamicsDrawerDirectionLeft | MSDynamicsDrawerDirectionRight];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.dynamicsDrawerViewController setPaneDragRevealEnabled:YES forDirection:MSDynamicsDrawerDirectionLeft | MSDynamicsDrawerDirectionRight];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    RSTitleView *titleView = (RSTitleView *)[[[NSBundle mainBundle] loadNibNamed:@"RSTitleView" owner:nil options:nil] firstObject];
    titleView.label.text = RSLocalizedString(@"New Card");
    self.navigationItem.titleView = titleView;
    
    self.colorView.layer.cornerRadius = 4.f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
