//
//  ErrorView.m
//  bigMouth
//
//  Created by he songhang on 13-3-28.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#import "ErrorView.h"

@implementation ErrorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSelf];
    }
    return self;
}

-(id)init{
    self = [super init];
    if (self) {
        [self initSelf];
    }
    return self;
}


-(void) initSelf{
    centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 190, 38)];
    centerView.backgroundColor = RGBA(0, 0, 0,0.9);
    lb_title = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 38)];
    lb_title.font = [UIFont systemFontOfSize:14];
    lb_title.numberOfLines = 20;
    lb_title.backgroundColor = [UIColor clearColor];
    lb_title.textColor = [UIColor whiteColor];
    [centerView addSubview:lb_title];
    [lb_title release];
    
    lineView = [[UIView alloc]initWithFrame:CGRectMake(112, 0, 0.7, 38)];
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.layer.opacity = 0.7;
    [centerView addSubview:lineView];
    [lineView release];
    
    btn_reload = [[UIButton alloc]initWithFrame:CGRectMake(112, 0, 40, 39)];
    [btn_reload setTitle:@"重试" forState:UIControlStateNormal];
    btn_reload.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn_reload addTarget:self action:@selector(reReques) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:btn_reload];
    [btn_reload release];
    
    lineView1 = [[UIView alloc]initWithFrame:CGRectMake(112+40, 0, 0.7, 38)];
    lineView1.backgroundColor = [UIColor whiteColor];
    lineView1.layer.opacity = 0.7;
    [centerView addSubview:lineView1];
    [lineView1 release];
    
    btn_cancel = [[UIButton alloc]initWithFrame:CGRectMake(112+40, 0, 40, 39)];
    [btn_cancel setTitle:@"X" forState:UIControlStateNormal];
    btn_cancel.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn_cancel addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:btn_cancel];
    [btn_cancel release];
    
    self.backgroundColor = RGBA(0, 0, 0, 0.3);
    centerView.center = self.center;
    [self addSubview:centerView];
    [centerView release];
}


+(id)showInView:(UIView *)view message:(NSString *)message  msg:(BeeMessage *)msg;{
    ErrorView *loadingView1 = (ErrorView *)[view viewWithTag:10087];
    if (loadingView1) {
        loadingView1.hidden = NO;
        loadingView1.msg = msg;
        loadingView1.message = message;
        return loadingView1;
    }
    ErrorView *loadingView = [[[ErrorView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)]autorelease];
    loadingView.layer.opacity = 0.0;
    loadingView.tag = 10087;
    [view addSubview:loadingView];
    [UIView animateWithDuration:0.5 animations:^{
        loadingView.layer.opacity = 1.0;
    }];
    loadingView.msg = msg;
    loadingView.message = message;
    return loadingView;
}

-(void)hideView{
    [UIView animateWithDuration:0.5 animations:^{
        self.layer.opacity = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)reReques{
    [UIView animateWithDuration:0.2 animations:^{
        self.layer.opacity = 0.0;
    }completion:^(BOOL finished) {
        if (_msg) {
            _msg.state = BeeMessage.STATE_CREATED;
            _msg.timeout = NO;
            _msg.failed = NO;
            _msg.errorCode = BeeMessage.ERROR_CODE_OK;
            _msg.errorDomain = nil;
            
            NSTimeInterval _initTimeStamp = [NSDate timeIntervalSinceReferenceDate];
            _msg.sendTimeStamp = _initTimeStamp;
            _msg.recvTimeStamp = _initTimeStamp;
            _msg.whenUpdate = nil;
            if ( [BeeMessageQueue sharedInstance].whenCreate )
            {
                [BeeMessageQueue sharedInstance].whenCreate( _msg );
            }
            [_msg.output removeAllObjects];
            [_msg send];
        }
        [self removeFromSuperview];
    }];
    
}


+(void)hideInView:(UIView *)view;{
    ErrorView *loadingView = (ErrorView *)[view viewWithTag:10087];
    if (loadingView) {
        [UIView animateWithDuration:0.5 animations:^{
            loadingView.layer.opacity = 0.0;
        } completion:^(BOOL finished) {
            [loadingView removeFromSuperview];
        }];
    }
}

-(void)setMessage:(NSString *)message{
    if (_message) {
        [_message release];
    }
    lb_title.text = message;
    _message = [message retain];
    if (_message) {
        CGSize size = [_message sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(100, 200)];
        if ((size.height + 10) > 38) {
            centerView.frame = CGRectMake(0, 0, 190, size.height + 10);
            lb_title.frame = CGRectMake(10, 0, 100, size.height + 10);
            lineView.frame = CGRectMake(112, 0, 0.7, size.height + 10);
            btn_reload.frame = CGRectMake(112, 0, 40, size.height + 10);
            lineView1.frame = CGRectMake(112+40, 0, 0.7, size.height + 10);
            btn_cancel.frame = CGRectMake(112+40, 0, 40, size.height + 10);
            centerView.center = self.center;
        }
    }
}

@end
