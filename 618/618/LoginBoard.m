//
//  LoginBoard.m
//  618
//
//  Created by he songhang on 13-4-18.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#import "LoginBoard.h"
#import "MainBoard.h"
#import "LoadingView.h"
#import "ErrorView.h"
#import "MainController.h"
#import "ShareValue.h"


@interface LoginBoard ()

@end

@implementation LoginBoard

-(void)loadMemberBtn{
    if ([ShareValue sharedInstance].remember) {
        [_btn_remember setImage:[UIImage imageNamed:@"box_check"] forState:UIControlStateNormal];
    }else{
        [_btn_remember setImage:[UIImage imageNamed:@"box_nocheck"] forState:UIControlStateNormal];
    }
}

- (IBAction)rememberAction:(id)sender {
    [ShareValue sharedInstance].remember = ![ShareValue sharedInstance].remember;
    [self loadMemberBtn];
}

- (IBAction)forgetAction:(id)sender {
    CC(@"!!!");
}

-(void)login{
    if (_tf_username.text.length == 0) {
        [BeeUIAlertView showMessage:@"请输入用户名" cancelTitle:@"确定"];
        return;
    }
    if (_tf_pwd.text.length == 0) {
        [BeeUIAlertView showMessage:@"请输入密码" cancelTitle:@"确定"];
        return;
    }
    [[self sendMessage:MainController.LOGIN timeoutSeconds:10] input:@"userName",_tf_username.text,@"password",_tf_pwd.text,nil];
    
}

- (IBAction)loginAction:(id)sender {
    [self login];
}


-(void)creatUI{
    _tf_username.nextChain = _tf_pwd;
    _tf_pwd.text = [ShareValue sharedInstance].password;
    _tf_username.text = [ShareValue sharedInstance].username;
    [self loadMemberBtn];
}

-(void)deleteUI{
    
}

//dyci
- (void)updateOnClassInjection;{
    if (!self.firstEnter) {
        [self deleteUI];
        [self creatUI];
    }
}


// BeeUIBoard signal goes here
- (void)handleUISignal_BeeUITextField:(BeeUISignal *)signal
{
    [super handleUISignal:signal];
    if ([signal is:BeeUITextField.WILL_ACTIVE]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(0, -200, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }else if([signal is:BeeUITextField.WILL_DEACTIVE] && _tf_pwd ==signal.source){
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }else if([signal is:BeeUITextField.RETURN]){
        if (_tf_pwd ==signal.source) {
            [_tf_pwd resignFirstResponder];
            [self login];
        }else{
            [_tf_pwd becomeFirstResponder];
        }
    }
}

// BeeUIBoard signal goes here
- (void)handleUISignal_BeeUIBoard:(BeeUISignal *)signal
{
    [super handleUISignal:signal];
    
    if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
	{
        [self creatUI];
	}
	else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
        [self deleteUI];
	}
	else if ( [signal is:BeeUIBoard.LOAD_DATAS] )
	{
        
	}
	else if ( [signal is:BeeUIBoard.WILL_APPEAR] )
	{
        
	}
	else if ( [signal is:BeeUIBoard.DID_DISAPPEAR] )
	{
        
	}else if ( [signal is:BeeUIBoard.WILL_DISAPPEAR] )
	{
        
        
	}
}

- (void)handleMainController:(BeeMessage *)msg
{
	[super handleMessage:msg];
	
	if ( [msg is:MainController.LOGIN] )
	{
        if ( msg.sending )
		{
			[LoadingView showInView:self.view msg:msg];
		}else{
            [LoadingView hideInView:self.view];
        }
		if(msg.timeout){
            [ErrorView showInView:self.view message:@"请求超时，请检查您的网络" msg:msg];
        }else if(msg.failed){
            [ErrorView showInView:self.view message:@"请求失败，请检查您的网络" msg:msg];
        }else if ( msg.succeed)
		{
            if ([msg.output boolAtPath:@"success"]) {
                [self.stack pushBoard:[MainBoard boardWithNibName:@"MainBoard"] animated:YES];
            }else{
                [BeeUIAlertView showMessage:[msg.output stringAtPath:@"msg"] cancelTitle:@"确定"];
            }
        }
	}
}


@end
