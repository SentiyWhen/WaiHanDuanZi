//
//  XMGTopic.m
//  Whdz
//
//  Created by 张文文 on 2018/8/17.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGTopic.h"

@implementation XMGTopic

- (CGFloat)cellHeight
{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    
    XMGFunc;
    
    // 文字的Y值
    _cellHeight += 55;
    
    // 文字的高度
    CGSize textMaxSize = CGSizeMake(XMGScreenW - 2 * XMGMarin, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + XMGMarin;
    
    // 工具条
    _cellHeight += 35 + XMGMarin;
    
    return _cellHeight;
}

@end
