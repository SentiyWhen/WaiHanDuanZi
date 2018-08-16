//
//  XMGVideoViewController.m
//  Whdz
//
//  Created by 张文文 on 2018/8/15.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGVideoViewController.h"

@interface XMGVideoViewController ()

@end

@implementation XMGVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XMGRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(XMGTitlesViewH, 0, 0, 0);
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%zd", self.class, indexPath.row];
    return cell;
}

@end
