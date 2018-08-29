//
//  XMGTopicViewController.m
//  Whdz
//
//  Created by 张文文 on 2018/8/28.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGTopicViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "XMGTopic.h"
#import <SVProgressHUD.h>
#import "XMGTopicCell.h"
#import <SDImageCache.h>
#import <MJRefresh/MJRefresh.h>

//#import "XMGAllViewController.h"
//#import "XMGVideoViewController.h"
//#import "XMGVoiceViewController.h"
//#import "XMGPictureViewController.h"
//#import "XMGWordViewController.h"

@interface XMGTopicViewController ()
/** 当前最后一条帖子数据的描述信息，专门用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;
/** 所有的帖子数据 */
@property (nonatomic, strong) NSMutableArray<XMGTopic *> *topics;

/** 请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

// 有了方法声明，点语法才会有智能提示
//- (XMGTopicType)type;
@end

@implementation XMGTopicViewController

/** 在这里实现type方法，仅仅是为了消除警告 */
- (XMGTopicType)type {return 0;}

/* cell的重用标识 */
static NSString * const XMGTopicCellId = @"XMGTopicCellId";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XMGGrayColor(206);
    
    self.tableView.contentInset = UIEdgeInsetsMake(XMGTitlesViewH, 0, XMGTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册cell
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([XMGTopicCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:XMGTopicCellId];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:XMGTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:XMGTitleButtonDidRepeatClickNotification object:nil];
    
    [self setupRefresh];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupRefresh
{
    // 广告条
//    UILabel *label = [[UILabel alloc] init];
//    label.backgroundColor = [UIColor blackColor];
//    label.frame = CGRectMake(0, 0, 0, 30);
//    label.textColor = [UIColor whiteColor];
//    label.text = @"广告";
//    label.textAlignment = NSTextAlignmentCenter;
//    self.tableView.tableHeaderView = label;
    
    // header
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // 自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 让header自动进入刷新
    [self.tableView.mj_header beginRefreshing];
    
    // footer
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

#pragma mark - 监听
/**
 *  监听tabBarButton重复点击
 */
- (void)tabBarButtonDidRepeatClick
{
    // 重复点击的不是精华按钮
    if (self.view.window == nil) return;
    
    // 显示在正中间的不是VideoViewController
    if (self.tableView.scrollsToTop == NO) return;
    
    // 进入下拉刷新
    [self.tableView.mj_header beginRefreshing];
   
}

/**
 *  监听titleButton重复点击
 */
- (void)titleButtonDidRepeatClick
{
    [self tabBarButtonDidRepeatClick];
}

#pragma mark - 数据处理
/**
 *  发送请求给服务器，下拉刷新数据
 */
- (void)loadNewTopics
{
    // 1.取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    
    // 3.发送请求
    [self.manager GET:XMGCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数据
        self.topics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != NSURLErrorCancelled) { // 并非是取消任务导致的error，其他网络问题导致的error
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
        }
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 *  发送请求给服务器，上拉加载更多数据
 */
- (void)loadMoreTopics
{
    // 1.取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    
    // 3.发送请求
    [self.manager GET:XMGCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数据
        NSArray *moreTopics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 累加到旧数组的后面
        [self.topics addObjectsFromArray:moreTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != NSURLErrorCancelled) { // 并非是取消任务导致的error，其他网络问题导致的error
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
        }
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 根据数据量显示或者隐藏footer
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topics[indexPath.row].cellHeight;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 清除内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
}



@end
