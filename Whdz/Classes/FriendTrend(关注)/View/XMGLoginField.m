//
//  XMGLoginField.m
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/13.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGLoginField.h"
#import "UITextField+Placeholder.h"

@implementation XMGLoginField

/*
 1.文本框光标变成白色
 2.文本框开始编辑的时候,占位文字颜色变成白色
 */

/* 原始方法
 NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
 attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
 self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
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
    
    // 快速设置占位文字颜色
     self.placeholderColor = [UIColor lightGrayColor];
    
    // 快速设置占位文字颜色 => 文本框占位文字可能是label => 验证占位文字是label => 拿到label => 查看label属性名(1.runtime 2.断点)
}

// 文本框开始编辑调用
- (void)textBegin
{
    // 设置占位文字颜色变成白色
    self.placeholderColor = [UIColor whiteColor];
    
}


// 文本框结束编辑调用
- (void)textEnd
{
    self.placeholderColor = [UIColor lightGrayColor];

}

@end
