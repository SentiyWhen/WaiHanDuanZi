//
//  XMGAdViewController.m
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/8.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGAdViewController.h"

@interface XMGAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;

@end

@implementation XMGAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置启动图片
    [self setupLaunchImage];
}

// 设置启动图片
- (void)setupLaunchImage
{
    // 6p:LaunchImage-800-Portrait-736h@3x.png
    // 6:LaunchImage-800-667h@2x.png
    // 5:LaunchImage-568h@2x.png
    // 4s:LaunchImage@2x.png
    if (iphone6P) { // 6p
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iphone6) { // 6
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iphone5) { // 5
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-568h"];
        
    } else if (iphone4) { // 4
        
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
//    self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    
    
    
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
