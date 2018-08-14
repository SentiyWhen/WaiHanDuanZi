//
//  XMGMeViewController.m
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/6.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGMeViewController.h"
#import "XMGSettingViewController.h"
#import <MJExtension/MJExtension.h>
#import <AFNetworking/AFNetworking.h>
#import "XMGSquareItem.h"
#import "XMGSquareCell.h"
/*
 搭建基本结构 -> 设置底部条 -> 设置顶部条 -> 设置顶部条标题字体 -> 处理导航控制器业务逻辑(跳转)
 */
static NSString * const ID = @"cell";
static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (XMGScreenW - (cols - 1) * margin) / cols
@interface XMGMeViewController ()<UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *squareItems;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation XMGMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航条
    [self setupNavBar];
    //设置tableView底部视图
    [self setupFootView];
    //请求数据
    [self loadData];
    /*
     跳转细节:
     1.collectionView高度重新计算
     2.collectionView不需要滚动
     */
}

#pragma mark - 请求数据
- (void)loadData
{
    // 1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    // 3.发送请求
    [mgr GET:@"https://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        NSArray *dictArr = responseObject[@"square_list"];

        // 字典数组转换成模型数组
        self->_squareItems = [XMGSquareItem mj_objectArrayWithKeyValuesArray:dictArr];
        
        // 处理数据
        [self resloveData];
        
        // 设置collectionView 计算collectionView高度 = rows * itemWH
        // Rows = (count - 1) / cols + 1  3 cols4
        NSInteger count = self->_squareItems.count;
        NSInteger rows = (count - 1) / cols + 1;
        // 设置collectioView高度
        self.collectionView.xmg_height = rows * itemWH;
        
        // 设置tableView滚动范围:自己计算
        self.tableView.tableFooterView = self.collectionView;
        //        self.tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.collectionView.frame));

        // 刷新表格
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XMGLog(@"%@",error);
        
    }];
    
}
#pragma mark - 处理请求完成数据
- (void)resloveData
{
    // 判断下缺几个
    // 3 % 4 = 3 cols - 3 = 1
    // 5 % 4 = 1 cols - 1 = 3
    NSInteger count = self.squareItems.count;
    NSInteger exter = count % cols;
    if (exter) {
        exter = cols - exter;
        for (int i = 0; i < exter; i++) {
            XMGSquareItem *item = [[XMGSquareItem alloc] init];
            [self.squareItems addObject:item];
        }
    }
    
}

- (void)setupFootView{
    /*
     1.初始化要设置流水布局
     2.cell必须要注册
     3.cell必须自定义
     */
    //创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell尺寸
    
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    //创建UiCollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    _collectionView = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;
    
    collectionView.dataSource = self;
    collectionView.scrollEnabled = NO;
    //注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"XMGSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
}

- (void)setupNavBar{
    // 设置
    UIBarButtonItem *settingItem =  [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    // 夜间模型
    UIBarButtonItem *nightItem =  [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
    
    // titleView
    self.navigationItem.title = @"我的";
}

- (void)night:(UIButton *)button{
    button.selected = !button.selected;
}

- (void)setting{
    //跳转到设置界面
    XMGSettingViewController *settingVc = [[XMGSettingViewController alloc] init];
    //隐藏底部条 必须在跳转之前设置
    settingVc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:settingVc animated:YES];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 从缓存池取
    XMGSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = self.squareItems[indexPath.row];
    
    return cell;
   
}

@end
