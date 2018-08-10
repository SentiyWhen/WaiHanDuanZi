//
//  XMGLoginRegisterViewController.m
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/10.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGLoginRegisterViewController.h"
#import "XMGLoginRegisterView.h"

@interface XMGLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;

@end

@implementation XMGLoginRegisterViewController
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickRegister:(UIButton *)sender {
    sender.selected = !sender.selected;
    //平移中间view
    _leadCons.constant = _leadCons.constant == 0 ? -self.middleView.xmg_width * 0.5 : 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     屏幕适配:
     1.一个view从xib加载,需不需在重新固定尺寸 一定要在重新设置一下
     
     2.在viewDidLoad设置控件frame好不好,开发中一般在viewDidLayoutSubviews布局子控件
     
     */
    
    // 创建登录view
    XMGLoginRegisterView *loginView = [XMGLoginRegisterView loginView];
    
    // 添加到中间的view
    [self.middleView addSubview:loginView];
    
    // 添加注册界面
    XMGLoginRegisterView *registerView = [XMGLoginRegisterView registerView];
    
    // 添加到中间的view
    [self.middleView addSubview:registerView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    XMGLoginRegisterView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.xmg_width * 0.5, self.middleView.xmg_height);
    
    XMGLoginRegisterView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake( self.middleView.xmg_width * 0.5, 0,self.middleView.xmg_width * 0.5, self.middleView.xmg_height);
    
}


@end
