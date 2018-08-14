//
//  UIBarButtonItem+Item.h
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/7.
//  Copyright © 2018年 zww. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)
// 快速创建UIBarButtonItem
+ (UIBarButtonItem *)itemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)backItemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;

+ (UIBarButtonItem *)itemWithimage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;
@end
