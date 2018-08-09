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

- (void)setItem:(XMGSubTagItem *)item{
    _item = item;
    
    _nameView.text = item.theme_name;
    _numView.text = item.sub_number;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
