//
//  XMGADItem.h
//  WaiHanDuanZi
//
//  Created by 张文文 on 2018/8/8.
//  Copyright © 2018年 zww. All rights reserved.
//

#import <Foundation/Foundation.h>
// w_picurl,ori_curl:跳转到广告界面,w,h
@interface XMGADItem : NSObject

/** 广告地址 */
@property (nonatomic, strong) NSString *w_picurl;
/** 点击广告跳转的界面 */
@property (nonatomic, strong) NSString *ori_curl;

@property (nonatomic, assign) CGFloat w;

@property (nonatomic, assign) CGFloat h;

@end
