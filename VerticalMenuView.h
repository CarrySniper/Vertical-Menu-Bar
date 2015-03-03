//
//  VerticalMenuView.h
//  竖直菜单栏Vertical Menu Bar
//
//  Created by 陈家庆 on 15-3-3.
//  Copyright (c) 2015年 shikee. All rights reserved.
//

#import <UIKit/UIKit.h>

//-----------自定义协议
@protocol VerticalMenuProtocol <NSObject>

-(void)getTag:(NSInteger)tag;//获取当前被选中下标值

@end
//==============================


@interface VerticalMenuView : UIView

@property(nonatomic,strong)NSArray *menuArray;//获取到的菜单名数组

-(void)setNameWithArray:(NSArray*)menuArray;//设置菜单名方法

//协议委托代理
@property (nonatomic,assign)id <VerticalMenuProtocol> myDelegate;


@end
