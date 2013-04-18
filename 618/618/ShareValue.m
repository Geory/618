//
//  ShareValue.m
//  618
//
//  Created by he songhang on 13-4-18.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#import "ShareValue.h"

@implementation ShareValue

DEF_SINGLETON(ShareValue)

-(void)setUsername:(NSString *)username{
    [[NSUserDefaults standardUserDefaults]setValue:username forKey:@"username"];
}

-(void)setPassword:(NSString *)password{
    [[NSUserDefaults standardUserDefaults]setValue:password forKey:@"password"];
}

-(NSString *)username{
    return [[NSUserDefaults standardUserDefaults]stringForKey:@"username"];
}

-(NSString *)password{
    return [[NSUserDefaults standardUserDefaults]stringForKey:@"password"];
}

-(void)setRemember:(BOOL)remember{
    [[NSUserDefaults standardUserDefaults]setBool:remember forKey:@"remember"];
}

-(BOOL)remember{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"remember"];
}

@end
