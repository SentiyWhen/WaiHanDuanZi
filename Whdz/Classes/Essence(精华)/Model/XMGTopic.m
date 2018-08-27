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
    
//    XMGFunc;
    
    // 文字的Y值
    _cellHeight += 55;
    
    // 文字的高度
    CGSize textMaxSize = CGSizeMake(XMGScreenW - 2 * XMGMarin, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + XMGMarin;
    
    //中间内容
    if (self.type != XMGTopicTypeWord) {
        CGFloat middleW = textMaxSize.width;
        CGFloat middleH = middleW * self.height / self.width;
        if (middleH >= XMGScreenH) { // 显示的图片高度超过一个屏幕，就是超长图片
            middleH = 200;
            self.bigPicture = YES;
        }
        CGFloat middleX = XMGMarin;
        CGFloat middleY = _cellHeight;
        self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _cellHeight += middleH + XMGMarin;
    }
    
    // 最新评论
    if (self.top_cmt.count) {
        //标题
        _cellHeight += 21;
        
        //内容
        NSDictionary *cmt = self.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        NSString *cmtText = [NSString stringWithFormat:@"%@ : %@",username,content];
        _cellHeight += [cmtText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height + XMGMarin;
    }
    
    // 工具条
    _cellHeight += 35 + XMGMarin;
    
    return _cellHeight;
}

@end
