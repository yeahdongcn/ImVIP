//
//  RSCardViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/7/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSCardViewController.h"

#import "RSAppDelegate.h"

#import "RSCardView.h"

#import "RSTitleView.h"

#import "RSNewCardViewController.h"

#import "SFUIViewMacroses.h"

#import "RSBigCardViewController.h"

#import <ColorUtils.h>

#import <UIColor+TDAdditions.h>

#import <RSBarcodes/RSCodeGen.h>

#import <RTSpinKitView.h>

#import <objc/runtime.h>

#import <SIAlertView.h>

new_class(RSCardShowButton, UIButton)

new_class(RSCardDeleteButton, UIButton)

@interface RSCardViewController ()

@property (nonatomic, weak) RSDynamicsDrawerViewController *dynamicsDrawerViewController;

@property (nonatomic, weak) IBOutlet UIView *cardContentView;

@property (nonatomic, weak) IBOutlet RSCardShowButton *showButton;

@property (nonatomic, weak) IBOutlet RSCardDeleteButton *deleteButton;

@property (nonatomic, strong) UIImage *snapshot;

@property (nonatomic, weak) IBOutlet UIView *spinnerBackgroundView;

@property (nonatomic, strong) RSTitleView *titleView;

@property (nonatomic, strong) RSCardView *cardView;

@end

@implementation RSCardViewController

- (IBAction)__onShow:(id)sender
{
    RSBigCardViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BigCard"];
    viewController.snapshot = self.snapshot;
    viewController.indexOfCard = self.indexOfCard;
    [self.navigationController pushViewController:viewController animated:NO];
}

- (IBAction)__onDelete:(id)sender
{
    BmobObject *card = [DataCenter getCachedCardAtIndex:self.indexOfCard];
    NSString *message = [NSString stringWithFormat:RSLocalizedString(@"%@ will be deleted"), [card objectForKey:@"title"]];
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:RSLocalizedString(@"Delete Card")
                                                     andMessage:message];
    
    [alertView addButtonWithTitle:RSLocalizedString(@"Cancel")
                             type:SIAlertViewButtonTypeCancel
                          handler:nil];
    [alertView addButtonWithTitle:RSLocalizedString(@"Delete")
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alert) {
                              // Start spinner
                              RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStylePlane color:[UIColor colorWithRGBValue:0xfafafa]];
                              [self.spinnerBackgroundView addSubview:spinner];
                              [spinner startAnimating];
                              
                              [DataCenter deleteCardAtIndex:self.indexOfCard withCallback:^(BOOL succeeded, NSError *error) {
                                  [spinner stopAnimating];
                                  [spinner removeFromSuperview];
                                  if (succeeded) {
                                      [self.navigationController popViewControllerAnimated:YES];
                                  } else {
                                      SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:RSLocalizedString(@"Please retry") andMessage:[error localizedDescription]];
                                      
                                      [alertView addButtonWithTitle:RSLocalizedString(@"Yes")
                                                               type:SIAlertViewButtonTypeDefault
                                                            handler:nil];
                                      
                                      alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromBottom;
                                      
                                      [alertView show];
                                  }
                              }];
                          }];
    
    alertView.transitionStyle = SIAlertViewTransitionStyleSlideFromBottom;
    
    [alertView show];
}

- (void)__onEdit
{
    [self performSegueWithIdentifier:@"EditCard" sender:self];
}

- (void)__reloadCard
{
    // Get the card ready
    BmobObject *card = [DataCenter getCachedCardAtIndex:self.indexOfCard];
    NSString *title = [card objectForKey:@"title"];
    NSString *codeValue = [card objectForKey:@"codeValue"];
    NSString *codeType = [card objectForKey:@"codeType"];
    UIColor *color = [UIColor colorWithString:[card objectForKey:@"color"]];
    NSMutableString *separatedCode = [NSMutableString stringWithString:kRSTextDefault];
    for (int i = 0; i < [codeValue length]; i++) {
        [separatedCode appendString:[codeValue substringWithRange:NSMakeRange(i, 1)]];
        [separatedCode appendString:kRSTextSpace];
    }
    NSString *code = [NSString stringWithString:separatedCode];
    UIImage *codeImage = [CodeGen genCodeWithContents:codeValue machineReadableCodeObjectType:codeType];
    CGFloat scale = 1.0f;
    if ([codeType isEqualToString:AVMetadataObjectTypeQRCode]
        || [codeType isEqualToString:AVMetadataObjectTypeAztecCode]) {
        while (codeImage.size.height * (scale + 0.5f) <= 60.0f) {
            scale += 0.5f;
        }
    } else {
        while (codeImage.size.width * (scale + 0.5f) <= 300.0f) {
            scale += 0.5f;
        }
    }
    
    // Update title view
    self.titleView.label.text = title;
    
    // Update card view content
    self.cardView.titleLabel.text = title;
    self.cardView.codeLabel.text = code;
    self.cardView.codeView.image = resizeImage(codeImage, scale);
    self.cardView.backgroundColor = color;
    
    if ([color isDarkColor]) {
        [self __updateLabelsColor:0xfafafa];
    } else {
        [self __updateLabelsColor:0x0a0a0a];
    }
}

- (void)__updateLabelsColor:(uint32_t)hex
{
    for (UIView *view in self.cardView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.textColor = [UIColor colorWithRGBValue:hex];
        }
    }
}

- (void)__cardDidUpdate:(NSNotification *)notification
{
    [self __reloadCard];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dynamicsDrawerViewController = ((RSAppDelegate *)[[UIApplication sharedApplication] delegate]).dynamicsDrawerViewController;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__cardDidUpdate:) name:RSDataCenterCardDidUpdate object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!self.snapshot) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, YES, 0.0f);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [window.layer renderInContext:context];
        self.snapshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_edit"] style:UIBarButtonItemStylePlain target:self action:@selector(__onEdit)];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:kRSTextDefault style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.deleteButton.layer.cornerRadius = 5.0f;
    self.showButton.layer.cornerRadius = 5.0f;
    
    self.titleView = (RSTitleView *)[[[NSBundle mainBundle] loadNibNamed:@"RSTitleView" owner:nil options:nil] firstObject];
    self.navigationItem.titleView = self.titleView;
    
    self.cardView = (RSCardView *)[[[NSBundle mainBundle] loadNibNamed:@"RSCardView" owner:nil options:nil] firstObject];
    self.cardView.autoresizingMask = UIViewAutoresizingMake(@"W+H");
    self.cardView.layer.cornerRadius = 11.0f;
    [self.cardContentView addSubview:self.cardView];
    
    [self __reloadCard];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EditCard"]) {
        RSNewCardViewController *controller = segue.destinationViewController;
        controller.indexOfCard = self.indexOfCard;
    }
}

@end
