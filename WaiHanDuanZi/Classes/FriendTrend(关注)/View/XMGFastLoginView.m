//
//  XMGFastLoginView.m
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/10.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGFastLoginView.h"

@implementation XMGFastLoginView

+ (instancetype)fastLoginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
