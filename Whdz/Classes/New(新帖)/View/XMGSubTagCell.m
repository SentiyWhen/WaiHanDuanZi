//
//  XMGSubTagCell.m
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/9.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGSubTagCell.h"
#import "XMGSubTagItem.h"
#import <UIImageView+WebCache.h>

@interface XMGSubTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numView;

@end


@implementation XMGSubTagCell

- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= 1;
    // 才是真正去给cell赋值
    [super setFrame:frame];
}

- (void)setItem:(XMGSubTagItem *)item{
    _item = item;
    
    // 设置内容
    _nameView.text = item.theme_name;
    
    // 判断下有没有>10000
    [self resolveNum];
    
    // 设置头像
    [_iconView xmg_setHeader:item.image_list];
}
// 处理订阅数字
- (void)resolveNum
{
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",_item.sub_number] ;
    NSInteger num = _item.sub_number.integerValue;
    if (num > 10000) {
        CGFloat numF = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",numF];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    _numView.text = numStr;
}
// 从xib加载就会调用一次
- (void)awakeFromNib {
    [super awakeFromNib];
//    _iconView.layer.cornerRadius = 30;
//    _iconView.layer.masksToBounds = YES;

//    self.layoutMargins = UIEdgeInsetsZero;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
