//
//  ViewController.m
//  竖直菜单栏Vertical Menu Bar
//
//  Created by 陈家庆 on 15-3-3.
//  Copyright (c) 2015年 shikee. All rights reserved.
//

#import "ViewController.h"
//1.包含头文件
#import "VerticalMenuView.h"
//2.添加协议委托代理
@interface ViewController ()<VerticalMenuProtocol>{
    VerticalMenuView *_menuView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];//不能放init处
    self.navigationItem.title = @"竖直菜单栏";
    self.view.backgroundColor = [UIColor brownColor];
    
    //3.创建并初始化，添加至视图
    _menuView = [[VerticalMenuView alloc]init];
    _menuView.frame = CGRectMake( 0, 64, 49,self.view.frame.size.height-64 );
    _menuView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_menuView];
    //4.设置菜单名数组
    NSArray *menuArray = [NSArray arrayWithObjects:@"我最喜欢",@"最新收藏",@"网络收藏",@"其他", nil];
    [_menuView setNameWithArray:menuArray];
    //5.设置委托代理
    _menuView.myDelegate=self;
}

//6.实现协议方法
-(void)getTag:(NSInteger)tag{
    self.navigationItem.title = [NSString stringWithFormat:@"%@",_menuView.menuArray[tag]];
    NSLog(@"菜单%ld",tag);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
