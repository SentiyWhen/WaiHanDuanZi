//
//  XMGTopicViewController.h
//  Whdz
//
//  Created by 张文文 on 2018/8/28.
//  Copyright © 2018年 zww. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGTopic.h"

@interface XMGTopicViewController : UITableViewController
/** 帖子的类型 */
//@property (nonatomic, assign, readonly) XMGTopicType type;

- (XMGTopicType)type;
@end

