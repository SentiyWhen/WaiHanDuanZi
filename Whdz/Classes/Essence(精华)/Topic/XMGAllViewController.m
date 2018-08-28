//
//  XMGAllViewController.m
//  Whdz
//
//  Created by 张文文 on 2018/8/15.
//  Copyright © 2018年 zww. All rights reserved.
//

//self.tableView.contentInset = UIEdgeInsetsMake(XMGTitlesViewH, 0, 0, 0);
//CGFloat ofsetY = self.tableView.contentSize.height + XMGTabBarH - self.tableView.xmg_height;

#import "XMGAllViewController.h"

@implementation XMGAllViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (XMGTopicType)type
{
    return XMGTopicTypeAll;
}
@end
