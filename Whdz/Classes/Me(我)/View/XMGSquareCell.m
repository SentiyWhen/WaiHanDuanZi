//
//  XMGSquareCell.m
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/13.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGSquareCell.h"
#import "XMGSquareItem.h"
#import <UIImageView+WebCache.h>

@interface XMGSquareCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end

@implementation XMGSquareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(XMGSquareItem *)item{
    _item = item;
    _nameView.text = item.name;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    
}

@end
