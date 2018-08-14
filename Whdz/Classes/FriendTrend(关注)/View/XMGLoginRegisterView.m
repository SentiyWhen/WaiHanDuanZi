//
//  XMGLoginRegisterView.m
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/10.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGLoginRegisterView.h"

@interface XMGLoginRegisterView()

@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;

@end

@implementation XMGLoginRegisterView

+ (instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)registerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UIImage *image = _loginRegisterButton.currentBackgroundImage;
    
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
    // 让按钮背景图片不要被拉伸
    [_loginRegisterButton setBackgroundImage:image forState:UIControlStateNormal];
}


@end
