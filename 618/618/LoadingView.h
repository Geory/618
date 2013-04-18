//
//  LoadingView.h
//  MeetingCloud
//
//  Created by he songhang on 13-3-28.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bee.h"

@interface LoadingView : UIView{
    UIImageView *imageView;
    UIView *centerView;
    UILabel *lb_title;
    UIButton *btn_cancel;
    UIView *lineView;
}

@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) BeeMessage *msg;

+(id)showInView:(UIView *)view msg:(BeeMessage *)msg;

+(void)hideInView:(UIView *)view;

@end
