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

@interface XMGEssenceViewController ()<UIScrollViewDelegate>

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
    // 添加第0个子控制器的view
    [self addChildVcViewIntoScrollView:0];
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
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 添加子控制器的view
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollerViewW = scrollView.xmg_width;
//    for (NSUInteger i = 0; i < count; ++i) {
//        //取出i位置子控制器的view
//        UIView *childVcView = self.childViewControllers[i].view;
//        childVcView.frame = CGRectMake(i * scrollerViewW, 0, scrollerViewW, scrollerViewH);
//        [scrollView addSubview:childVcView];
//    }
    
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
    
    NSUInteger index = titleButton.tag;
    [UIView animateWithDuration:0.3 animations:^{
        self.titleUnderline.xmg_width = titleButton.titleLabel.xmg_width + 10;
        self.titleUnderline.xmg_centerX = titleButton.xmg_centerX;
        
//        NSUInteger index = [self.titlesView.subviews indexOfObject:titleButton];
//        CGFloat offsetX = self.scrollView.xmg_width * index;
        //滚动scrollview
        CGFloat offsetX = self.scrollView.xmg_width * index;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        [self addChildVcViewIntoScrollView:index];
    }];
    
    // 设置index位置对应的tableView.scrollsToTop = YES， 其他都设置为NO
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        // 如果view还没有被创建，就不用去处理
        if (!childVc.isViewLoaded) continue;
        
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        //        if (i == index) { // 是标题按钮对应的子控制器
        //            scrollView.scrollsToTop = YES;
        //        } else {
        //            scrollView.scrollsToTop = NO;
        //        }
        scrollView.scrollsToTop = (i == index);
    }
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  当用户松开scrollView并且滑动结束时调用这个代理方法（scrollView停止滚动的时候）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //求出标题按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.xmg_width;
    
    //点击对应的标题按钮
    XMGTitleButton * titleButton = self.titlesView.subviews[index];
//    XMGTitleButton *titleButton = [self.titlesView viewWithTag:index];
    [self titlesButtonClick:titleButton];
}

#pragma mark - 其他
/**
 *  添加第index个子控制器的view到scrollView中
 */
- (void)addChildVcViewIntoScrollView:(NSUInteger)index
{
    //取出按钮索引对应的控制器
    UIViewController *childVc = self.childViewControllers[index];
    
    // 如果view已经被加载过，就直接返回
    if (childVc.isViewLoaded) return;
    
    // 取出index位置对应的子控制器view
    UIView *childVcView = childVc.view;
    //    if (childVcView.superview) return;
    //    if (childVcView.window) return;
    
    // 设置子控制器view的frame
    CGFloat scrollViewW = self.scrollView.xmg_width;
    CGFloat scrollViewH = self.scrollView.xmg_height;
    childVcView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, scrollViewH);
//    childVcView.frame = self.scrollView.bounds;
    // 添加子控制器的view到scrollView中
    [self.scrollView addSubview:childVcView];
}


/**
 *  当用户松开scrollView时调用这个代理方法（结束拖拽的时候）
 */
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    XMGFunc
//}

/*
 -[UIView setSelected:]: unrecognized selector sent to instance 0x7fbcba35ab10
 
 -[XMGPerson length]: unrecognized selector sent to instance 0x7fbcba35ab10
 将XMGPerson当做NSString来使用
 
 - (void)test:(NSString *)string
 {
 string.length;
 }
 id str = [[XMGPerson alloc] init];
 [self test:str];
 
 -[XMGPerson count]: unrecognized selector sent to instance 0x7fbcba35ab10
 将XMGPerson当做NSArray或者NSDictionary来使用
 
 -[XMGPerson setObject:forKeyedSubscript:]: unrecognized selector sent to instance 0x7fbcba35ab10
 名字中带有Subscript的方法，一般都是集合的方法，比如NSMutableDictionary\NSMutableArray的方法
 将XMGPersonNSMutableDictionary来使用
 */

/*
 A
 -D1  0
 -E1 10
 -E2 0
 -D2 10
 -F1 0
 -F2 0
 -D3 0
 
 [A viewWithTag:10]; // 返回E1
 */

/*
 @implementation UIView
 
 - (UIView *)viewWithTag:(NSInteger)tag
 {
 // 如果自己的tag符合要求，就返回自己
 if (self.tag == tag) return self;
 
 // 遍历子控件（也包括子控件的子控件...），直到找到符合条件的子控件为止
 for (UIView *subview in self.subviews) {
 //        if (subview.tag == tag) return subview;
 UIView *resultView = [subview viewWithTag:tag];
 if (resultView) return resultView;
 }
 
 return nil;
 }
 
 @end
 */


@end
