//
//  RSNavigationBar.m
//  ImVIP
//
//  Created by R0CKSTAR on 1/16/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSNavigationBar.h"

@implementation RSNavigationBar

#define kDefaultMargin           10
#define TABLE_CELL_BACKGROUND    { 1, 1, 1, 1, 0.866, 0.866, 0.866, 1}

- (void)drawRect:(CGRect)aRect
{
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    int lineWidth = 1;
	
    CGRect rect = [self bounds];
    CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
    miny -= 1;
	
    CGFloat locations[2] = { 0.0, 1.0 };
    CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef myGradient = nil;
    CGFloat components[8] = TABLE_CELL_BACKGROUND;
    CGContextSetStrokeColorWithColor(c, [[UIColor grayColor] CGColor]);
    CGContextSetLineWidth(c, lineWidth);
    CGContextSetAllowsAntialiasing(c, YES);
    CGContextSetShouldAntialias(c, YES);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, minx, miny);
    CGPathAddArcToPoint(path, NULL, minx, maxy, midx, maxy, kDefaultMargin);
    CGPathAddArcToPoint(path, NULL, maxx, maxy, maxx, miny, kDefaultMargin);
    CGPathAddLineToPoint(path, NULL, maxx, miny);
    CGPathAddLineToPoint(path, NULL, minx, miny);
    CGPathCloseSubpath(path);
    
    // Fill and stroke the path
    CGContextSaveGState(c);
    CGContextAddPath(c, path);
    CGContextClip(c);
    
    myGradient = CGGradientCreateWithColorComponents(myColorspace, components, locations, 2);
    CGContextDrawLinearGradient(c, myGradient, CGPointMake(minx,miny), CGPointMake(minx,maxy), 0);
    
    CGContextAddPath(c, path);
    CGPathRelease(path);
    CGContextStrokePath(c);
    CGContextRestoreGState(c);
    
    CGColorSpaceRelease(myColorspace);
    CGGradientRelease(myGradient);
    return;
}

@end
