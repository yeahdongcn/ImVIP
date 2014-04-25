//
//  RSUser.h
//  ImVIP
//
//  Created by R0CKSTAR on 4/11/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface RSUser : AVUser <AVSubclassing>

@property (nonatomic) NSUInteger score;

@property (nonatomic, strong) AVRelation *a;

@property (nonatomic, strong) AVRelation *myCards;

@end
