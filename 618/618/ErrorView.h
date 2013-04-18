//
//  ErrorView.h
//  bigMouth
//
//  Created by he songhang on 13-3-28.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bee.h"

@interface ErrorView : UIView{
    UIView *centerView;
    UILabel *lb_title;
    UIButton *btn_cancel;
    UIButton *btn_reload;
    UIView *lineView;
    UIView *lineView1;
}

@property(nonatomic,retain) NSString *message;
@property(nonatomic,retain) BeeMessage *msg;

+(id)showInView:(UIView *)view message:(NSString *)mssage  msg:(BeeMessage *)msg;

+(void)hideInView:(UIView *)view;

@end

