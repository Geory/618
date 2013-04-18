//
//  LoginBoard.h
//  618
//
//  Created by he songhang on 13-4-18.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#import "Bee_UIBoard.h"
#import "Bee.h"

@interface LoginBoard : BeeUIBoard

@property (retain, nonatomic) IBOutlet BeeUITextField *tf_username;

@property (retain, nonatomic) IBOutlet BeeUITextField *tf_pwd;

@property (retain, nonatomic) IBOutlet UIButton *btn_remember;

- (IBAction)rememberAction:(id)sender;

- (IBAction)forgetAction:(id)sender;

- (IBAction)loginAction:(id)sender;

@end
