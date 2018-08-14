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
/*
 搭建基本结构 -> 设置底部条 -> 设置顶部条 -> 设置顶部条标题字体 -> 处理导航控制器业务逻辑(跳转)
 */
static NSString * const ID = @"cell";

@interface XMGMeViewController ()<UICollectionViewDataSource>

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
        NSLog(@"%@",responseObject);
        
//        NSArray *dictArr = responseObject[@"square_list"];
//
//        // 字典数组转换成模型数组
//        _squareItems = [XMGSquareItem mj_objectArrayWithKeyValuesArray:dictArr];
//
//        // 刷新表格
//        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XMGLog(@"%@",error);
        
    }];
    
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
    NSInteger cols = 4;
    CGFloat margin = 1;
    CGFloat itemWH = (XMGScreenW - (cols - 1) * margin) / cols;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    //创建UiCollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;
    
    collectionView.dataSource = self;
    
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
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 从缓存池取
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    return cell;
   
}




@end
