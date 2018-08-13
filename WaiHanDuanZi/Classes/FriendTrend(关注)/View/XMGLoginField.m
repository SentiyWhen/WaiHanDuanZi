//
//  XMGLoginField.m
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/13.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGLoginField.h"

@implementation XMGLoginField

/*
 1.文本框光标变成白色
 2.文本框开始编辑的时候,占位文字颜色变成白色
 */

- (void)awakeFromNib
{
    [super awakeFromNib];
    // 设置光标的颜色为白色
    self.tintColor = [UIColor whiteColor];
    
    // 监听文本框编辑: 1.代理 2.通知 3.target
    // 原则:不要自己成为自己代理
    // 开始编辑
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    // 结束编辑
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
    
    // 快速设置占位文字颜色
    // self.placeholderColor = [UIColor redColor];
    
}

// 文本框开始编辑调用
- (void)textBegin
{
    // 设置占位文字颜色变成白色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
}


// 文本框结束编辑调用
- (void)textEnd
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
}

@end
