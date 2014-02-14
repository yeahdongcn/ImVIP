//
//  BmobFile.h
//  BmobSDK
//
//  Created by donson on 13-9-10.
//  Copyright (c) 2013年 donson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BmobConfig.h"

@interface BmobFile : NSObject



/**
 *	文件名
 */
@property(readwrite,assign)NSString  *name;

/**
 *	文件的地址
 */
@property(readwrite,assign)NSString  *url;

/**
 *	文件的组名
 */
@property(readwrite,assign)NSString  *group;



/**
 *	创建BmobFile对象
 *
 *	@param	className	关联的数据库表名
 *	@param	filePath	文件路径
 *
 *	@return	BmobFile对象实例
 */
-(id)initWithClassName:(NSString*)className withFilePath:(NSString*)filePath;

/**
 *  创建BmobFile对象
 *
 *  @param className 关联的数据库表名
 *  @param fileName  文件名称，请加上后缀
 *  @param data      二进制数据
 *
 *  @return BmobFile对象实例
 */
-(id)initWithClassName:(NSString *)className  withFileName:(NSString*)fileName  withFileData:(NSData*)data;

/**
 *	上传文件并保存
 */
-(BOOL)save;

@end
