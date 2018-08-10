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

@end

@implementation XMGLoginRegisterViewController
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickRegister:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    XMGLoginRegisterView *registerView = [XMGLoginRegisterView registerView];
    [self.middleView addSubview:registerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
