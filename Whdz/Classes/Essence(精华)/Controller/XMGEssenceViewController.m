//
//  XMGEssenceViewController.m
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/6.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGEssenceViewController.h"

// UIBarButtonItem:描述按钮具体的内容
// UINavigationItem:设置导航条上内容(左边,右边,中间)
// tabBarItem: 设置tabBar上按钮内容(tabBarButton)

@interface XMGEssenceViewController ()

@property (nonatomic, weak) UIView *titlesView;

@end

@implementation XMGEssenceViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏
    [self setupNavBar];
    //scrollview
    [self setupScrollView];
    //标题栏
    [self setupTitlesView];
}

- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
}

- (void)setupTitlesView {
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.frame = CGRectMake(0, 64, self.view.xmg_width, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //标题栏按钮
    [self setupTitlesButtons];
}

- (void)setupTitlesButtons {
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSUInteger count = titles.count;
    //标题按钮尺寸
    CGFloat titleButtonW = self.titlesView.xmg_width / count;
    CGFloat titleButtonH = self.titlesView.xmg_height;
    //创建5个标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *titleButton  = [[UIButton alloc] init];
        [titleButton addTarget:self action:@selector(titlesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        titleButton.frame = CGRectMake(titleButtonW*i, 0, titleButtonW, titleButtonH);
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
}

- (void)setupNavBar {
    //左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    //右侧边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
    //titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

#pragma mark - 监听
- (void)game {
    XMGFunc;
}

- (void)titlesButtonClick :(UIButton *)titleButton {
    XMGFunc;
}



@end
