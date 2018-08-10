//
//  XMGFriendTrendViewController.m
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/6.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGFriendTrendViewController.h"
#import "XMGLoginRegisterViewController.h"

@interface XMGFriendTrendViewController ()

@end

@implementation XMGFriendTrendViewController
- (IBAction)clickBtn:(id)sender {
    //进入登陆注册页面
    XMGLoginRegisterViewController * loginVc = [[XMGLoginRegisterViewController alloc] init];
    [self presentViewController:loginVc animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBar];
}

#pragma mark - 设置导航条
- (void)setupNavBar
{
    // 左边按钮
    // 把UIButton包装成UIBarButtonItem.就导致按钮点击区域扩大
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    
    // titleView
    self.navigationItem.title = @"我的关注";
    
}

// 推荐关注
- (void)friendsRecomment
{
    
}

@end
