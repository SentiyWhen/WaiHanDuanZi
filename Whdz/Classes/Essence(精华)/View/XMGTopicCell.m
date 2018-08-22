//
//  XMGTopicCell.m
//  Whdz
//
//  Created by 张文文 on 2018/8/17.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "XMGTopicCell.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>
#import "XMGTopicPictureView.h"
#import "XMGTopicVideoView.h"

@interface XMGTopicCell()
// 控件的命名 -> 功能 + 控件类型
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;

/* 中间控件 */
/** 图片控件 */
@property (nonatomic, weak) XMGTopicPictureView *pictureView;
/** 视频控件 */
@property (nonatomic, weak) XMGTopicVideoView *videoView;

@end

@implementation XMGTopicCell
#pragma mark - 懒加载
- (XMGTopicPictureView *)pictureView
{
    if (!_pictureView) {
        XMGTopicPictureView *pictureView = [XMGTopicPictureView xmg_viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (XMGTopicVideoView *)videoView
{
    if (!_videoView) {
        XMGTopicVideoView *videoView = [XMGTopicVideoView xmg_viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopic:(XMGTopic *)topic
{
    _topic = topic;
    
    // 顶部控件的数据
    [self.profileImageView xmg_setHeader:topic.profile_image];
    
    self.nameLabel.text = topic.name;
    self.text_label.text = topic.text;
    self.passtimeLabel.text = topic.passtime;
    // 底部按钮的文字
    [self setupButtonTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:topic.comment placeholder:@"评论"];
    
    //最新评论
    if (topic.top_cmt.count) {
        self.topCmtView.hidden = NO;
        
        NSDictionary *cmt = topic.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@ : %@",username,content];
    } else {
        self.topCmtView.hidden = YES;
    }
    
    // 中间的内容
    if (topic.type == XMGTopicTypePicture) { // 图片
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
    } else if (topic.type == XMGTopicTypeVideo) { // 视频
        self.videoView.topic = topic;
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
    } else if (topic.type == XMGTopicTypeWord) { // 段子
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.topic.type == XMGTopicTypePicture) { // 图片
        self.pictureView.frame = self.topic.middleFrame;
    } else if (self.topic.type == XMGTopicTypeVideo) { // 视频
        self.videoView.frame = self.topic.middleFrame;
    }
}

/**
 *  设置按钮文字
 *  @param number      按钮的数字
 *  @param placeholder 数字为0时显示的文字
 */
- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= XMGMarin;
    
    [super setFrame:frame];
}

@end
