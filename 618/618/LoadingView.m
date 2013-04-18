//
//  LoadingView.m
//  MeetingCloud
//
//  Created by he songhang on 13-3-28.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

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
    centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 38)];
    centerView.backgroundColor = RGBA(0, 0, 0,0.9);
    lb_title = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 70, 38)];
    lb_title.font = [UIFont systemFontOfSize:14];
    lb_title.backgroundColor = [UIColor clearColor];
    lb_title.textColor = [UIColor whiteColor];
    self.title = @"正在加载...";
    [centerView addSubview:lb_title];
    [lb_title release];
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(80, 7, 24, 24)];
    imageView.image = [UIImage imageNamed:@"reload"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [centerView addSubview:imageView];
    [imageView release];
    
    lineView = [[UIView alloc]initWithFrame:CGRectMake(112, 0, 0.7, 38)];
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.layer.opacity = 0.7;
    [centerView addSubview:lineView];
    [lineView release];
    
    btn_cancel = [[UIButton alloc]initWithFrame:CGRectMake(112, 0, 40, 39)];
    [btn_cancel setTitle:@"X" forState:UIControlStateNormal];
    [btn_cancel addTarget:self action:@selector(cancelReques) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:btn_cancel];
    [btn_cancel release];
    
    self.backgroundColor = RGBA(0, 0, 0, 0.3);
    
    centerView.center = self.center;
    [self addSubview:centerView];
    [centerView release];
}

- (void)spin
{
    CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    spinAnimation.byValue = [NSNumber numberWithFloat:2*M_PI];
    spinAnimation.duration = 1.0;
    spinAnimation.delegate = self;
    [imageView.layer addAnimation:spinAnimation forKey:@"spinAnimation"];
}

+(id)showInView:(UIView *)view msg:(BeeMessage *)msg;{
    LoadingView *loadingView1 = (LoadingView *)[view viewWithTag:10086];
    if (loadingView1) {
        loadingView1.msg = msg;
        return loadingView1;
    }
    LoadingView *loadingView = [[[LoadingView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)]autorelease];
    loadingView.layer.opacity = 0.0;
    loadingView.tag = 10086;
    [view addSubview:loadingView];
    [UIView animateWithDuration:0.5 animations:^{
        loadingView.layer.opacity = 1.0;
    }];
    loadingView.msg = msg;
    [loadingView spin];
    return loadingView;
}


-(void)cancelReques{
    if (_msg) {
        [_msg cancelRequests];
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.layer.opacity = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


+(void)hideInView:(UIView *)view;{
    LoadingView *loadingView = (LoadingView *)[view viewWithTag:10086];
    if (loadingView) {
        [UIView animateWithDuration:0.5 animations:^{
            loadingView.layer.opacity = 0.0;
        } completion:^(BOOL finished) {
            [loadingView removeFromSuperview];
        }];
    }
}

-(void)setTitle:(NSString *)title{
    if (_title) {
        [_title release];
    }
    lb_title.text = title;
    _title = [title retain];
    if (_title) {
        CGSize size = [_title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(70, 200)];
        if ((size.height + 10) > 38) {
            centerView.frame = CGRectMake(0, 0, 150, size.height + 10);
            lb_title.frame = CGRectMake(10, 0, 70,size.height + 10);
            lineView.frame = CGRectMake(112, 0, 0.7, size.height + 10);
            btn_cancel.frame = CGRectMake(112, 0, 40, size.height + 10);
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(80, (size.height - 14)/2, 24, 24)];
            centerView.center = self.center;
        }
    }
}


#pragma mark - Animation Delegates

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
   [self spin];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
