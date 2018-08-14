//
//  XMGFastButton.m
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/13.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGFastButton.h"

@implementation XMGFastButton

- (void)layoutSubviews{
    [super layoutSubviews];
    // 设置图片位置
    self.imageView.xmg_y = 0;
    self.imageView.xmg_centerX = self.xmg_width * 0.5;
    
    // 设置标题位置
    self.titleLabel.xmg_y = self.xmg_height - self.titleLabel.xmg_height;
    
    // 计算文字宽度 , 设置label的宽度
    [self.titleLabel sizeToFit];
    
    self.titleLabel.xmg_centerX = self.xmg_width * 0.5;
}

@end
