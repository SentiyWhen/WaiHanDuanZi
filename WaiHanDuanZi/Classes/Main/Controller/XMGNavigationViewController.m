//
//  XMGNavigationViewController.m
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/7.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGNavigationViewController.h"

@interface XMGNavigationViewController ()

@end

@implementation XMGNavigationViewController

+ (void)load {
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    // 只要是通过模型设置,都是通过富文本设置
    // 设置导航条标题 => UINavigationBar
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
    // 设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 设置返回按钮,只有非根控制器
    if (self.childViewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"]  target:self action:@selector(back) title:@"返回"];
    }
    // 真正在跳转
    [super pushViewController:viewController animated:YES];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end
