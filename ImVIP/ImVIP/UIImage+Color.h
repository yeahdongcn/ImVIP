//
//  UIImage+Color.h
//  ImVIP
//
//  Created by R0CKSTAR on 1/16/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

// http://stackoverflow.com/questions/1213790/how-to-get-a-color-image-in-iphone-sdk
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color;

@end
