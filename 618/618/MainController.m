//
//  MainController.m
//  618
//
//  Created by he songhang on 13-4-18.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#import "MainController.h"
#import "URLUtils.h"
#import "Bee.h"
#import "ShareValue.h"
#import "UserInfo.h"

@implementation MainController

DEF_MESSAGE(LOGIN)

-(NSMutableDictionary *) postDataByMessage:(BeeMessage *)msg{
    NSMutableDictionary *input = [NSMutableDictionary dictionaryWithDictionary:msg.input];
    return input;
}

-(NSObject *) dataDictByBeeMessage:(BeeMessage *)msg{
    NSDictionary * dict = (NSDictionary *)[msg.response objectFromJSONData];
    CC(@"response== %@",dict);
    if ( nil == dict )
    {
        [msg.output setValue:@NO forKey:@"success"];
        [msg.output setValue:@"请求失败" forKey:@"msg"];
        return nil;
    }
    NSNumber *number = [dict numberAtPath:@"returnCode"];
    if ([number intValue] != 1) {
        [msg.output setValue:@NO forKey:@"success"];
        NSString *data = [dict objectForKey:@"msg"];
        if (data && data.length > 0) {
            [msg.output setValue:data forKey:@"msg"];
        }else{
            [msg.output setValue:@"请求失败" forKey:@"msg"];
        }
        return nil;
    }else{
        [msg.output setValue:@YES forKey:@"success"];
        return dict;
    }
}


- (void)LOGIN:(BeeMessage *)msg
{
	if ( msg.sending )
	{
		NSString *url = [URLUtils urlWithMethod:URL_LOGIN];
        NSString *userName = [msg.input stringAtPath:@"userName"];
        NSString *password = [msg.input stringAtPath:@"password"];
        [msg HTTP_POST:url].PARAM(@"",userName).PARAM(@"password",password);
	}
	else if ( msg.progressed )
	{
        
	}
	else if ( msg.succeed )
	{
        NSDictionary * data = (NSDictionary *)[self dataDictByBeeMessage:msg];
		if (data) {
            NSDictionary *userDict = [data dictAtPath:@"user"];
            UserInfo *userinfo = (UserInfo*)[userDict objectForClass:[UserInfo class]];
            [msg.output setValue:userinfo forKey:@"user"];
            [ShareValue sharedInstance].userinfo = userinfo;
            
            NSString *username  = [msg.input stringAtPath:@"userName"];
            NSString *password = [msg.input stringAtPath:@"password"];
            [ShareValue sharedInstance].username = nil;
            [ShareValue sharedInstance].password = nil;
            if ([ShareValue sharedInstance].remember) {
                [ShareValue sharedInstance].username = username;
                [ShareValue sharedInstance].password = password;
            }
            
        }
	}
	else if ( msg.failed )
	{
		
	}
	else if ( msg.cancelled )
	{
        
	}
}


@end
