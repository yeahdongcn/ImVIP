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

#import <ColorUtils.h>

#import <UIColor+TDAdditions.h>

#import <RSBarcodes/RSCodeGen.h>

new_class(RSCardShowButton, UIButton)

new_class(RSCardDeleteButton, UIButton)

@interface RSCardViewController ()

@property (nonatomic, weak) RSDynamicsDrawerViewController *dynamicsDrawerViewController;

@property (nonatomic, weak) IBOutlet UIView *cardContentView;

@property (nonatomic, weak) IBOutlet RSCardShowButton   *showButton;

@property (nonatomic, weak) IBOutlet RSCardDeleteButton *deleteButton;

@end

@implementation RSCardViewController

- (void)__onEdit
{
    [self performSegueWithIdentifier:@"EditCard" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EditCard"]) {
        RSNewCardViewController *controller = segue.destinationViewController;
        controller.indexOfCard = self.indexOfCard;
    }
}

- (void)__setLabelsColorContainedIn:(UIView *)contentView withColorHex:(uint32_t)hex
{
    for (UIView *view in contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.textColor = [UIColor colorWithRGBValue:hex];
        }
    }
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(__onEdit)];
    
    // Get the card ready
    BmobObject *card = [DataCenter getCachedCardAtIndex:self.indexOfCard];
    NSString *title = [card objectForKey:@"title"];
    NSString *codeValue = [card objectForKey:@"codeValue"];
    NSString *codeType = [card objectForKey:@"codeType"];
    NSMutableString *separatedCode = [NSMutableString stringWithString:kRSTextDefault];
    for (int i = 0; i < [codeValue length]; i++) {
        [separatedCode appendString:[codeValue substringWithRange:NSMakeRange(i, 1)]];
        [separatedCode appendString:kRSTextSpace];
    }
    NSString *code = [NSString stringWithString:separatedCode];
    UIImage *codeImage = [CodeGen genCodeWithContents:codeValue machineReadableCodeObjectType:codeType];
    CGFloat scale = 1.0f;
    while (codeImage.size.width * (scale + 0.5f) <= 300.0f) {
        scale += 0.5f;
    }
    
    RSTitleView *titleView = (RSTitleView *)[[[NSBundle mainBundle] loadNibNamed:@"RSTitleView" owner:nil options:nil] firstObject];
    titleView.label.text = title;
    self.navigationItem.titleView = titleView;
    
    RSCardView *cardView = (RSCardView *)[[[NSBundle mainBundle] loadNibNamed:@"RSCardView" owner:nil options:nil] firstObject];
    // Update card view appearance
    cardView.autoresizingMask = UIViewAutoresizingMake(@"W+H");
    cardView.layer.cornerRadius = 11.f;
    UIColor *backgroundColor = [UIColor colorWithString:[card objectForKey:@"color"]];
    cardView.backgroundColor = backgroundColor;
    // Update card view content
    cardView.titleLabel.text = title;
    cardView.codeLabel.text = code;
    cardView.codeView.image = resizeImage(codeImage, scale);
    
    // TODO: text colors to be determined
    if ([backgroundColor isDarkColor]) {
        [self __setLabelsColorContainedIn:cardView withColorHex:0xfafafa];
    } else {
        [self __setLabelsColorContainedIn:cardView withColorHex:0x0a0a0a];
    }
    [self.cardContentView addSubview:cardView];
}

@end
