//
//  XMGEssenceViewController.m
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/6.
//  Copyright © 2018年 zww. All rights reserved.
//

/*
 名字叫attributes并且是NSDictionary *类型的参数，它的key一般都有以下规律
 1.iOS7开始
 1> 所有的key都来源于： NSAttributedString.h
 2> 格式基本都是：NS***AttributeName
 
 2.iOS7之前
 1> 所有的key都来源于： UIStringDrawing.h
 2> 格式基本都是：UITextAttribute***
 */

#import "XMGEssenceViewController.h"
#import "XMGTitleButton.h"

#import "XMGAllViewController.h"
#import "XMGVideoViewController.h"
#import "XMGVoiceViewController.h"
#import "XMGPictureViewController.h"
#import "XMGWordViewController.h"

// UIBarButtonItem:描述按钮具体的内容
// UINavigationItem:设置导航条上内容(左边,右边,中间)
// tabBarItem: 设置tabBar上按钮内容(tabBarButton)

@interface XMGEssenceViewController ()

/** 用来存放所有子控制器view的scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 标题下划线 */
@property (nonatomic, weak) UIView *titleUnderline;
/** 上一次点击的标题按钮 */
@property (nonatomic, weak) XMGTitleButton *previousClickedTitleButton;

@end

@implementation XMGEssenceViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化子控制器
    [self setupAllChildVcs];
    //导航栏
    [self setupNavBar];
    //scrollview
    [self setupScrollView];
    //标题栏
    [self setupTitlesView];
}

- (void)setupAllChildVcs {
    [self addChildViewController:[[XMGAllViewController alloc] init]];
    [self addChildViewController:[[XMGVideoViewController alloc] init]];
    [self addChildViewController:[[XMGVoiceViewController alloc] init]];
    [self addChildViewController:[[XMGPictureViewController alloc] init]];
    [self addChildViewController:[[XMGWordViewController alloc] init]];
}

- (void)setupScrollView {
    // 不允许自动修改UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.frame = self.view.bounds;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 添加子控制器的view
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollerViewW = scrollView.xmg_width;
    CGFloat scrollerViewH = scrollView.xmg_height;
    
    for (NSUInteger i = 0; i < count; ++i) {
        //取出i位置子控制器的view
        UIView *childVcView = self.childViewControllers[i].view;
        childVcView.frame = CGRectMake(i * scrollerViewW, 0, scrollerViewW, scrollerViewH);
        [scrollView addSubview:childVcView];
    }
    
    scrollView.contentSize = CGSizeMake(count * scrollerViewW, 0);
    
}

- (void)setupTitlesView {
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.frame = CGRectMake(0, 64, self.view.xmg_width, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //标题栏按钮
    [self setupTitlesButtons];
    
    //标题栏下划线
    [self setupTitleUnderline];
}

- (void)setupTitlesButtons {
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSUInteger count = titles.count;
    //标题按钮尺寸
    CGFloat titleButtonW = self.titlesView.xmg_width / count;
    CGFloat titleButtonH = self.titlesView.xmg_height;
    //创建5个标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        XMGTitleButton *titleButton  = [[XMGTitleButton alloc] init];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titlesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        titleButton.frame = CGRectMake(titleButtonW*i, 0, titleButtonW, titleButtonH);
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
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

- (void)setupTitleUnderline {
    //取到标题按钮
    
    XMGTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    //下划线
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.xmg_height = 2;
    titleUnderline.xmg_y = self.titlesView.xmg_height - titleUnderline.xmg_height;
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    // 切换按钮状态
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
    [firstTitleButton.titleLabel sizeToFit];
    self.titleUnderline.xmg_width = firstTitleButton.titleLabel.xmg_width + 10;
    self.titleUnderline.xmg_centerX = firstTitleButton.xmg_centerX;
}

#pragma mark - 监听
- (void)game {
    XMGFunc;
}

- (void)titlesButtonClick :(XMGTitleButton *)titleButton {
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.titleUnderline.xmg_width = titleButton.titleLabel.xmg_width + 10;
        self.titleUnderline.xmg_centerX = titleButton.xmg_centerX;
        
//        NSUInteger index = [self.titlesView.subviews indexOfObject:titleButton];
//        CGFloat offsetX = self.scrollView.xmg_width * index;
        //滚动scrollview
        CGFloat offsetX = self.scrollView.xmg_width * titleButton.tag;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    }];
}



@end
