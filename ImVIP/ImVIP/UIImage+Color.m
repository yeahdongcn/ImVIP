//
//  UIImage+Color.m
//  ImVIP
//
//  Created by R0CKSTAR on 1/16/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    // Create a context of the appropriate size
    UIGraphicsBeginImageContext(size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    // Build a rect of appropriate size at origin 0,0
    CGRect fillRect = CGRectMake(0, 0, size.width, size.height);
    
    // Set the fill color
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    
    // Fill the color
    CGContextFillRect(currentContext, fillRect);
    
    // Snap the image and close the context
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [[self class] imageWithColor:color andSize:CGSizeMake(1, 1)];
}

@end
