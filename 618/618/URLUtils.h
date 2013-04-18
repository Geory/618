//
//  URLUtils.h
//  bigMouth
//
//  Created by he songhang on 13-1-31.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#define URL_LOGIN @"login"
#define URL_QINDAO @"attendance/update"
#define URL_QINTUI @"attendance/update"
#define URL_QINJIA @"vacation/update"
#define URL_QINJIAORDERLIST @"vacation/page"
#define URL_QINJIAORDERSHOW @"vacation/show"
#define URL_KAOQINLIST @"attendanceday/page"
#define URL_HUISHOU @""

@interface URLUtils : NSObject

+(NSDictionary *) postdatasWithKeysAndValues:(NSString *)params,...;

//+(NSString *) md5signWithParams:(NSDictionary *)params;

+(NSString *) urlWithMethod:(NSString *)method;

@end
