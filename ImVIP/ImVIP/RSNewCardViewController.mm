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

#import <AVFoundation/AVFoundation.h>

#import <TDImageColors.h>

#import <SpinKit/RTSpinKitView.h>

#import <ColorUtils.h>

new_class(RSNewCardLabel, UILabel)

new_class(RSNewCardButton, UIButton)

new_class(RSNewCardTextField, UITextField)

@interface RSNewCardViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (nonatomic, weak) RSDynamicsDrawerViewController *dynamicsDrawerViewController;

@property (nonatomic, weak) IBOutlet UITextField *titleField;

@property (nonatomic, weak) IBOutlet UITextField *subtitleField;

@property (nonatomic, weak) IBOutlet UITextField *codeField;

@property (nonatomic, weak) IBOutlet UIView *colorView;

@property (nonatomic, weak) IBOutlet UIView *spinnerBackgroundView;

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, strong) AVMetadataMachineReadableCodeObject *codeObject;

@end

@implementation RSNewCardViewController

- (void)__dismissKeyboard
{
    if ([self.titleField isFirstResponder]) {
        [self.titleField resignFirstResponder];
        return;
    }
    
    if ([self.subtitleField isFirstResponder]) {
        [self.subtitleField resignFirstResponder];
        return;
    }
    
    if ([self.codeField isFirstResponder]) {
        [self.codeField resignFirstResponder];
        return;
    }
}

- (IBAction)__openImage:(id)sender
{
    [self __dismissKeyboard];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = NO;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)__openCamera:(id)sender
{
    [self __dismissKeyboard];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = NO;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)__saveCard:(id)sender
{
    [self __dismissKeyboard];
    
    NSString *title = [[self.titleField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([title isEqualToString:RSStringEmpty]) {
        [[[UIAlertView alloc] initWithTitle:RSLocalizedString(@"Require fields should not be empty") message:RSLocalizedString(@"Business name field is empty") delegate:nil cancelButtonTitle:RSLocalizedString(@"Yes") otherButtonTitles:nil] show];
        return;
    }
    
    if (self.codeObject == nil) {
        NSString *code = [[self.codeField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (code == nil) {
            [[[UIAlertView alloc] initWithTitle:RSLocalizedString(@"Require Fields should not be empty") message:RSLocalizedString(@"Code field is empty") delegate:nil cancelButtonTitle:RSLocalizedString(@"Yes") otherButtonTitles:nil] show];
            return;
        } else {
            self.codeObject = [[AVMetadataMachineReadableCodeObject alloc] init];
        }
    }
    
    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStylePlane color:[UIColor colorWithRGBValue:0x6755c7]];
    [self.spinnerBackgroundView addSubview:spinner];
    [spinner startAnimating];
    
    NSMutableDictionary *card = [NSMutableDictionary new];
    [card setObject:title forKey:@"title"];
    NSString *subtitle = [[self.subtitleField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [card setObject:subtitle forKey:@"subtitle"];
    if ([self.codeObject stringValue] == nil
        || [[self.codeObject stringValue] isEqualToString:RSStringEmpty]) {
        NSString *codeValue = [[self.codeField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [card setObject:codeValue forKey:@"codeValue"];
        [card setObject:AVMetadataObjectTypeUPCECode forKey:@"codeType"];
    } else {
        [card setObject:[self.codeObject stringValue] forKey:@"codeValue"];
        [card setObject:[self.codeObject type] forKey:@"codeType"];
    }
    [card setObject:[self.color stringValue] forKey:@"color"];
    
    [DataCenter saveCard:card withCallback:^(BOOL succeeded, NSError *error) {
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        if (succeeded) {
            [self.navigationController popViewControllerAnimated:YES];
            
            [Achievements setNumberOfCards:[DataCenter numberOfCachedCard] + 1];
        } else {
            [[[UIAlertView alloc] initWithTitle:RSLocalizedString(@"Please retry") message:[error localizedDescription] delegate:nil cancelButtonTitle:RSLocalizedString(@"Yes") otherButtonTitles:nil] show];
        }
    }];
}

- (IBAction)__scanCode:(id)sender
{
    [self __dismissKeyboard];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dynamicsDrawerViewController = ((RSAppDelegate *)[[UIApplication sharedApplication] delegate]).dynamicsDrawerViewController;
        self.color = [UIColor grayColor];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.dynamicsDrawerViewController.panePanGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.dynamicsDrawerViewController.panePanGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RSTitleView *titleView = (RSTitleView *)[[[NSBundle mainBundle] loadNibNamed:@"RSTitleView" owner:nil options:nil] firstObject];
    titleView.label.text = RSLocalizedString(@"New Card");
    self.navigationItem.titleView = titleView;
    
    self.colorView.layer.cornerRadius = 3.f;
    
    self.titleField.delegate = self;
    self.subtitleField.delegate = self;
    self.codeField.delegate = self;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    RSTitleView *titleView = (RSTitleView *)[[[NSBundle mainBundle] loadNibNamed:@"RSTitleView" owner:nil options:nil] firstObject];
    titleView.label.text = viewController.navigationItem.title;
    viewController.navigationItem.titleView = titleView;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    TDImageColors *imageColors = [[TDImageColors alloc] initWithImage:image count:5];
    dispatch_group_leave(group);
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"%@", imageColors.colors);
        self.colorView.backgroundColor = [imageColors.colors lastObject];
    });
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
