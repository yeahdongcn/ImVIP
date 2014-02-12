//
//  Bmob.h
//  BmobSDK
//
//  Created by donson on 13-7-31.
//  Copyright (c) 2013年 donson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Bmob : NSObject


/**
 *	向Bmob注册程序
 *
 *	@param	appKey	在网站注册的appkey
 */
+(void)registWithAppKey:(NSString*)appKey;

@end
