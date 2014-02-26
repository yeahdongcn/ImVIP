//
//  JBStringConstants.h
//  JBChartViewDemo
//
//  Created by Terry Worona on 11/6/13.
//  Copyright (c) 2013 Jawbone. All rights reserved.
//

#define localize(key, default) NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle], default, nil)

#pragma mark - Labels

#define kJBStringLabel0 localize(@"label.0", @"0")
#define kJBStringLabel24 localize(@"label.24", @"24")

#define kJBStringLabelTimes localize(@"label.times", @"次")
#define kJBStringLabelHour localize(@"label.hour", @"点")
