//
//  XMGSubTagViewController.m
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/9.
//  Copyright © 2018年 zww. All rights reserved.
//

//
//  XMGSubTagViewController.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/15.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGSubTagViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "XMGSubTagItem.h"
#import <MJExtension/MJExtension.h>
#import "XMGSubTagCell.h"

static NSString * const ID = @"cell";

@interface XMGSubTagViewController ()

@property (nonatomic, strong) NSArray *subTags;

@end

@implementation XMGSubTagViewController
// 接口文档: 请求url(基本url+请求参数) 请求方式
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 展示标签数据 -> 请求数据(接口文档) -> 解析数据(写成Plist)(image_list,sub_number,theme_name) -> 设计模型 -> 字典转模型 -> 展示数据
//    [self loadData];
    [self loadMockData];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"XMGSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
}

- (void)loadMockData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"topic.json" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    
    _subTags = [XMGSubTagItem mj_objectArrayWithKeyValuesArray:array];
    [self.tableView reloadData];
}

#pragma mark - 请求数据
- (void)loadData
{
    // 1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    // 3.发送请求
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable responseObject) {
        //        [responseObject writeToFile:@"/Users/xiaomage/Desktop/课堂共享/11大神班上课资料/08-项目/0315/代码/05-订阅标签/tag.plist" atomically:YES];
        NSLog(@"%@",responseObject);
        // 字典数组转换模型数组
        _subTags = [XMGSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 自定义cell
    XMGSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    // 获取模型
    XMGSubTagItem *item = self.subTags[indexPath.row];
    cell.item = item;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

@end
