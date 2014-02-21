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

@property (nonatomic, weak) IBOutlet UITextField *tagField;

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
    
    if ([self.tagField isFirstResponder]) {
        [self.tagField resignFirstResponder];
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
    if ([title length] == 0) {
        [[[UIAlertView alloc] initWithTitle:RSLocalizedString(@"Required fields should not be empty") message:RSLocalizedString(@"Business name field is empty") delegate:nil cancelButtonTitle:RSLocalizedString(@"Yes") otherButtonTitles:nil] show];
        return;
    }
    
    if (!self.codeObject) {
        NSString *code = [[self.codeField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([code length] == 0) {
            [[[UIAlertView alloc] initWithTitle:RSLocalizedString(@"Required fields should not be empty") message:RSLocalizedString(@"Code field is empty") delegate:nil cancelButtonTitle:RSLocalizedString(@"Yes") otherButtonTitles:nil] show];
            return;
        }
    }
    
    // Start spinner
    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStylePlane color:[UIColor colorWithRGBValue:0x6755c7]];
    [self.spinnerBackgroundView addSubview:spinner];
    [spinner startAnimating];
    
    // Get everything necessary
    NSString *tag = [[self.tagField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *codeValue = self.codeObject ? [self.codeObject stringValue] : [[self.codeField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *codeType = self.codeObject ? [self.codeObject type] : AVMetadataObjectTypeUPCECode;
    NSString *color = [self.color stringValue];
    
    // Update & save callback
    void (^callback)(BOOL, NSError *, BOOL) = [^(BOOL succeeded, NSError *error, BOOL needUpdateAchievements) {
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        if (succeeded) {
            if (needUpdateAchievements) {
                [Achievements setNumberOfCards:[DataCenter numberOfCachedCard] + 1];
            }
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [[[UIAlertView alloc] initWithTitle:RSLocalizedString(@"Please retry") message:[error localizedDescription] delegate:nil cancelButtonTitle:RSLocalizedString(@"Yes") otherButtonTitles:nil] show];
        }
    } copy];
    
    BmobObject *card = [DataCenter getCachedCardAtIndex:self.indexOfCard];
    if (card) {
        // We have the card object so next step is to compare each value for key and then update
        if (![[card objectForKey:@"title"] isEqualToString:title]) {
            [card setObject:title forKey:@"title"];
        }
        if (![[card objectForKey:@"tag"] isEqualToString:tag]) {
            [card setObject:tag forKey:@"tag"];
        }
        if (![[card objectForKey:@"codeValue"] isEqualToString:codeValue]) {
            [card setObject:codeValue forKey:@"codeValue"];
        }
        if (![[card objectForKey:@"codeType"] isEqualToString:codeType]) {
            [card setObject:codeType forKey:@"codeType"];
        }
        if (![[card objectForKey:@"color"] isEqualToString:color]) {
            [card setObject:color forKey:@"color"];
        }
        
        [DataCenter updateCardAtIndex:self.indexOfCard withCallback:^(BOOL succeeded, NSError *error) {
            callback(succeeded, error, NO);
        }];
    } else {
        // We don't have the card yet, we have create then save
        NSMutableDictionary *card = [NSMutableDictionary new];
        [card setObject:title forKey:@"title"];
        [card setObject:tag forKey:@"tag"];
        [card setObject:codeValue forKey:@"codeValue"];
        [card setObject:codeType forKey:@"codeType"];
        [card setObject:color forKey:@"color"];
        
        [DataCenter saveCard:card withCallback:^(BOOL succeeded, NSError *error) {
            callback(succeeded, error, YES);
        }];
    }
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
        self.indexOfCard = NSNotFound;
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
    self.tagField.delegate = self;
    self.codeField.delegate = self;
}

- (void)setIndexOfCard:(NSUInteger)indexOfCard
{
    _indexOfCard = indexOfCard;
    
    if (_indexOfCard != NSNotFound) {
        double delayInSeconds = .3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            BmobObject *card = [DataCenter getCachedCardAtIndex:self.indexOfCard];
            self.titleField.text = [card objectForKey:@"title"];
            self.codeField.text = [card objectForKey:@"codeValue"];
        });
    }
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
        self.colorView.backgroundColor = [imageColors.colors firstObject];
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
