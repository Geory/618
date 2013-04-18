//
//  MainBoard.m
//  618
//
//  Created by he songhang on 13-4-18.
//  Copyright (c) 2013年 he songhang. All rights reserved.
//

#import "MainBoard.h"

@interface MainBoard ()

@end

@implementation MainBoard




-(void)creatUI{
    
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
- (void)handleUISignal_BeeUIBoard:(BeeUISignal *)signal
{
    //    [super handleUISignal:signal];
    
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

@end
