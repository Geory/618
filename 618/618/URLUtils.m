//
//  URLUtils.m
//  bigMouth
//
//  Created by he songhang on 13-1-31.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#import "URLUtils.h"
#import "Bee.h"

#define SERVERURL @"http://117.27.144.51:8100/sfaapi/router/rest?method=%@"

@implementation URLUtils


+(NSDictionary *) postdatasWithKeysAndValues:(NSString *)first,...{
    NSMutableDictionary *dic  = [NSMutableDictionary dictionary];
    va_list args;
    va_start( args, first );
    NSString *	key = (NSString *)first;
    while (key != nil) {
        NSObject *	value = va_arg( args, NSObject * );
        if (value!=nil) {
            [dic setValue:value forKeyPath:key];
        }
        key = va_arg( args, NSString * );
    }
    va_end( args );
    
    return dic;

}
//
//+(NSString *) md5signWithParams:(NSDictionary *)params;{
//    NSMutableString *md5sing = [NSMutableString string];
//    if (params) {
//        NSArray *keys = [params allKeys];
//       keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//           NSString *str1 = obj1;
//           NSString *str2 = obj2;
//           return [str1 compare:str2];
//       }];
//        for (NSString * key in keys) {
//            NSObject *value = [params objectForKey:key];
//            [md5sing appendString:[value description]];
//        }
//    }
////    [md5sing appendString:APIKEY];
//    return [md5sing MD5];
//}

+(NSString *) urlWithMethod:(NSString *)method;{
    NSString *postUrl = [NSString stringWithFormat:SERVERURL,method];
    return postUrl;
}

@end
