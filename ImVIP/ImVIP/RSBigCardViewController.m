//
//  RSBigCardViewController.m
//  ImVIP
//
//  Created by R0CKSTAR on 2/21/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSBigCardViewController.h"

#import "ANBlurredImageView.h"

#import <RSBarcodes/RSCodeGen.h>

@interface RSBigCardViewController ()

@property (nonatomic, weak) IBOutlet ANBlurredImageView *blurredView;

@property (nonatomic, weak) IBOutlet UIButton *closeButton;

@property (nonatomic, strong) UIImageView *codeView;

@end

@implementation RSBigCardViewController

- (void)__clicked
{
    [self.blurredView blurOutAnimationWithDuration:0.3f completion:^{
        [self.navigationController setNavigationBarHidden:NO];
        [self.navigationController popViewControllerAnimated:NO];
    }];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.codeView.alpha = 0;
        self.closeButton.alpha = 0;
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.closeButton addTarget:self action:@selector(__clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.blurredView setImage:self.snapshot];
    [self.blurredView setBlurAmount:1];
    
    BmobObject *card = [DataCenter getCachedCardAtIndex:self.indexOfCard];
    NSString *codeValue = [card objectForKey:@"codeValue"];
    NSString *codeType = [card objectForKey:@"codeType"];
    UIImage *codeImage = [CodeGen genCodeWithContents:codeValue machineReadableCodeObjectType:codeType];
    CGFloat scale = 1.0f;
    if ([codeType isEqualToString:AVMetadataObjectTypeQRCode]
        || [codeType isEqualToString:AVMetadataObjectTypeAztecCode]) {
        while (codeImage.size.height * (scale + 0.5f) <= 300.0f) {
            scale += 0.5f;
        }
    } else {
        while (codeImage.size.width * (scale + 0.5f) <= 460.0f) {
            scale += 0.5f;
        }
    }
    self.codeView = [[UIImageView alloc] initWithImage:resizeImage(codeImage, scale)];
    if (!([codeType isEqualToString:AVMetadataObjectTypeQRCode]
          || [codeType isEqualToString:AVMetadataObjectTypeAztecCode])) {
        self.codeView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    self.codeView.center = self.view.center;
    self.codeView.alpha = 0;
    [self.view addSubview:self.codeView];
    
    self.closeButton.alpha = 0;
    if (!([codeType isEqualToString:AVMetadataObjectTypeQRCode]
          || [codeType isEqualToString:AVMetadataObjectTypeAztecCode])) {
        self.closeButton.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.blurredView blurInAnimationWithDuration:0.3f];
        [UIView animateWithDuration:0.3f animations:^{
            self.codeView.alpha = 1.0f;
            self.closeButton.alpha = 1.0f;
        }];
    });
}

@end
