//
//  XMGTabBarController.m
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/6.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "UIImage+Image.h"
#import "XMGTabBarController.h"
#import "XMGMeViewController.h"
#import "XMGNewViewController.h"
#import "XMGEssenceViewController.h"
#import "XMGPublishViewController.h"
#import "XMGFriendTrendViewController.h"
#import "XMGTabBar.h"
#import "XMGNavigationViewController.h"


@interface XMGTabBarController ()

@end

@implementation XMGTabBarController
#warning TODO:发布按钮显示不出来
/*
 问题:
 1.选中按钮的图片被渲染 -> iOS7之后默认tabBar上按钮图片都会被渲染 1.修改图片 2.通过代码 √
 2.选中按钮的标题颜色:黑色 标题字体大 -> 对应子控制器的tabBarItem √
 3.发布按钮显示不出来 分析:为什么其他图片可以显示,我的图片不能显示 => 发布按钮图片太大,导致显示不出来
 
 1.图片太大,系统帮你渲染 => 能显示 => 位置不对 => 高亮状态达不到
 
 解决:不能修改图片尺寸, 效果:让发布图片居中
 
 2.如何解决:系统的TabBar上按钮状态只有选中,没有高亮状态 => 中间发布按钮 不能用系统tabBarButton => 发布按钮 不是 tabBarController子控制器
 
 1.自定义tabBar
 
 */

// 只会调用一次
+ (void)load
{
    // 获取哪个类中UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];

    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
    // 创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];

    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1 添加子控制器(5个子控制器)
    [self setupAllChildVC];
    
    //2 设置tabBar上按钮内容
    [self setupAllTitleBtn];
    
    //3 自定义tabbar
    [self setupTabBar];
}

#pragma mark - 自定义tabBar
- (void)setupTabBar {
    XMGTabBar * tabBar = [[XMGTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)setupAllChildVC {
    //精华
    XMGEssenceViewController *essenceVc = [[XMGEssenceViewController alloc] init];
    XMGNavigationViewController *nav = [[XMGNavigationViewController alloc] initWithRootViewController:essenceVc];
    [self addChildViewController:nav];
    //新帖
    XMGNewViewController *newVc = [[XMGNewViewController alloc] init];
    XMGNavigationViewController *nav1 = [[XMGNavigationViewController alloc] initWithRootViewController:newVc];
    [self addChildViewController:nav1];
    
    //关注
    XMGFriendTrendViewController *ftVc = [[XMGFriendTrendViewController alloc] init];
    XMGNavigationViewController *nav3 = [[XMGNavigationViewController alloc] initWithRootViewController:ftVc];
    [self addChildViewController:nav3];
    //我
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([XMGMeViewController class]) bundle:nil];
    // 加载箭头指向控制器
    XMGMeViewController *meVc = [storyboard instantiateInitialViewController];
    XMGNavigationViewController *nav4 = [[XMGNavigationViewController alloc] initWithRootViewController:meVc];
    [self addChildViewController:nav4];
}

- (void)setupAllTitleBtn {
    // 0:nav
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精华";
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    
    // 1:new
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];

    // 3:ft
    UINavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    // 4:me
    UINavigationController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
    
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
