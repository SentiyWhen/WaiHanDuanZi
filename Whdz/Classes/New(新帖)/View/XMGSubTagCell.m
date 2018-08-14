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
    
    _nameView.text = item.theme_name;
    [self resolveNum];
    
//    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 1.开启图形上下文
        // 比例因素:当前点与像素比例
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        // 2.描述裁剪区域
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        // 3.设置裁剪区域;
        [path addClip];
        // 4.画图片
        [image drawAtPoint:CGPointZero];
        // 5.取出图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        // 6.关闭上下文
        UIGraphicsEndImageContext();
        
        _iconView.image = image;
    }];
 
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
