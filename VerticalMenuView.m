//
//  VerticalMenuView.m
//  竖直菜单栏Vertical Menu Bar
//
//  Created by 陈家庆 on 15-3-3.
//  Copyright (c) 2015年 shikee. All rights reserved.
//

#import "VerticalMenuView.h"

@implementation VerticalMenuView

/*
 //iOS8 SDK要自己添加这个方法
 - (id)initWithFrame:(CGRect)frame
 {
 self = [super initWithFrame:frame];
 if (self) {
 // Initialization code
 
 }
 return self;
 }
 */

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

#pragma mark- 创建菜单名数组和设置菜单名方法
-(void)setNameWithArray:(NSArray*)menuArray{
    
    _menuArray = menuArray;
    
    //一个间隔
    CGFloat SPACE = (self.frame.size.height)/[_menuArray count];
    
    for (int i = 0; i<[menuArray count];i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (self.frame.size.width>35) {
            CGFloat space = (self.frame.size.width - 36)/2;
            btn.frame = CGRectMake(space, SPACE*i, 35, SPACE);
        }else{
            btn.frame = CGRectMake(0, SPACE*i, 35, SPACE);
        }
        btn.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;//UIButton中的文字适应button宽度自动换行
        btn.backgroundColor = [UIColor clearColor];
        
        btn.tag = i;
        if (btn.tag == 0) {
            btn.enabled = NO;
        }
        
        //设置按钮字体大小 颜色 状态
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[menuArray objectAtIndex:i]];
        [str addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, [str  length])];
        [btn setAttributedTitle:str forState:UIControlStateNormal];
        
        NSMutableAttributedString *selStr = [[NSMutableAttributedString alloc]initWithString:[menuArray objectAtIndex:i]];
        [selStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, [str  length])];
        [btn setAttributedTitle:selStr forState:UIControlStateDisabled];
        
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        //分割线
        if (i>0 && self.frame.size.height>16) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(8, SPACE*i, self.frame.size.width-16, 1)];
            line.backgroundColor = [UIColor grayColor];
            [self addSubview:line];
        }
    }
    //侧边划线
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width-1.5, 0, 1.5, self.frame.size.height)];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
    
    //标识当选被选中划线
    UIView *markLine = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width-3, 0, 3, SPACE+1)];
    markLine.tag = 999;
    markLine.backgroundColor = [UIColor orangeColor];
    [self addSubview:markLine];
}

#pragma mark- 菜单按钮点击事件
- (void)btnClick:(UIButton*)sender{
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)subView;
            if (subBtn.tag == sender.tag) {
                [subBtn setEnabled:NO];
            }else {
                [subBtn setEnabled:YES];
            }
        }
    }
    
    //计算每个按钮间隔
    CGFloat SPACE = (self.frame.size.height)/[_menuArray count];
    
    UIView *markView = [self viewWithTag:999];
    [UIView animateWithDuration:0.2f animations:^{
        CGRect markFrame =markView.frame;
        markFrame.origin.y = sender.tag*SPACE;
        markView.frame = markFrame;
    }];
    if ([self.myDelegate respondsToSelector:@selector(getTag:)]) {
        [self.myDelegate getTag:sender.tag];
    }

}

-(void)dealloc{
    _menuArray = nil;
    _myDelegate = nil;
}


@end
