//
//  ShareValue.h
//  618
//
//  Created by he songhang on 13-4-18.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"
#import "UserInfo.h"

@interface ShareValue : NSObject

@property(nonatomic,retain) NSString *username;
@property(nonatomic,retain) NSString *password;
@property(nonatomic,assign) BOOL remember;

@property(nonatomic,retain) UserInfo *userinfo;

AS_SINGLETON(ShareValue)

@end
