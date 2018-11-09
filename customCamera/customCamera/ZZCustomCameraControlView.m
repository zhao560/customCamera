//
//  ZZCustomCameraControlView.m
//  YouAiXue
//
//  Created by root on 2018/11/6.
//  Copyright © 2018年 凉凉. All rights reserved.
//

#import "ZZCustomCameraControlView.h"

@interface ZZCustomCameraControlView ()
/// 拍照
@property (nonatomic, strong) UIButton *takeBtn;
/// 相册
@property (nonatomic, strong) UIButton *photoBtn;
/// 关闭
@property (nonatomic, strong) UIButton *closeBtn;
/// 跳过
@property (nonatomic, strong) UIButton *skipBtn;
@property (nonatomic, strong) UILabel *skipSynopsis;
/// 分割线
@property (nonatomic, strong) UIView *lineView;
@end

@implementation ZZCustomCameraControlView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    /// 分割线
    self.lineView = [UIView new];
    [self addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    /// 拍一下，去问问题
    UILabel *subLb = [UILabel zz_labelWithTitle:@"（一次多个问题建议可以多张拍摄\n最多不超过3张)" color:UIColor.whiteColor fontSize:10];
    subLb.numberOfLines = 0;
    [self addSubview:subLb];
    
    UILabel *titleLb = [UILabel zz_labelWithTitle:@"拍一下，去问问题" color:UIColor.whiteColor fontSize:14];
    titleLb.backgroundColor = [UIColor colorFromHexString:@"#666666" Alpha:1.0];
    titleLb.layer.masksToBounds = true;
    titleLb.layer.cornerRadius = 3.5;
    [self addSubview:titleLb];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorFromHexString:@"#666666" Alpha:0.9];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@87);
    }];
    
    [subLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(bottomView.mas_top).offset(-14);
    }];
    
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(subLb.mas_top).offset(-14);
        make.height.equalTo(@22);
        make.width.equalTo(@143);
    }];
    
    /// 拍照
    self.takeBtn = [UIButton zz_buttonWithTitle:nil imageName:@"home_customCamera_take" target:self action:@selector(take)];
    [bottomView addSubview:self.takeBtn];
    
    [self.takeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bottomView);
        make.width.height.equalTo(@78);
    }];
    
    /// 相册
    self.photoBtn = [UIButton zz_buttonWithTitle:nil imageName:@"home_customCamera_photo" target:self action:@selector(openPhoto)];
    [bottomView addSubview:self.photoBtn];
    
    [self.photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.takeBtn);
        make.left.equalTo(bottomView).offset(10);
        make.width.height.equalTo(@47);
    }];
    
    /// 关闭
    self.closeBtn = [UIButton zz_buttonWithTitle:nil imageName:@"home_customCamera_close" target:self action:@selector(close)];
    [bottomView addSubview:self.closeBtn];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.takeBtn);
        make.right.equalTo(bottomView).offset(-10);
        make.width.height.equalTo(self.photoBtn);
    }];
    
    /// 跳过
    self.skipBtn = [UIButton zz_buttonWithTitle:@"跳过" color:UIColor.whiteColor fontSize:14 target:self action:@selector(skip)];
    self.skipBtn.backgroundColor = [UIColor colorFromHexString:@"#666666" Alpha:0.9];
    self.skipBtn.layer.masksToBounds = true;
    self.skipBtn.layer.cornerRadius = 2.5;
    [self addSubview:self.skipBtn];
    
    [self.skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@35);
        make.height.equalTo(@17);
        make.top.equalTo(self).offset(21);
        make.right.equalTo(self).offset(-21);
    }];
    
    /// 纯文字提示
    self.skipSynopsis = [UILabel zz_labelWithTitle:@"(纯文字提\n问请选择)" color:UIColor.whiteColor fontSize:8];
    self.skipSynopsis.numberOfLines = 0;
    [self addSubview:self.skipSynopsis];
    
    [self.skipSynopsis mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.skipBtn);
        make.top.equalTo(self.skipBtn.mas_bottom).offset(6);
    }];
    
    CGFloat rowMargin = kScreenH / 4;
    CGFloat colMargin = kScreenW / 3;
    for (int i = 0; i < 5; i++) {
        CALayer *layer = [CALayer new];
        layer.backgroundColor = UIColor.whiteColor.CGColor;
        [self.lineView.layer addSublayer:layer];
        CGFloat y = i < 3 ? (i * rowMargin + rowMargin) : 0;
        CGFloat x = i < 3 ? 0 : ((i - 3) * colMargin + colMargin);
        CGFloat w = i < 3 ? kScreenW : 1;
        CGFloat h = i < 3 ? 1 : kScreenH;
        layer.frame = CGRectMake(x, y, w, h);
    }
}

/// 拍照
-(void)take
{
    !self.takeBlock ? : self.takeBlock();
}

/// 打开相册
-(void)openPhoto
{
    !self.openPhotoBlock ? : self.openPhotoBlock();
}

/// 关闭
-(void)close
{
    !self.closeBlock ? : self.closeBlock();
}

/// 跳过
-(void)skip
{
    !self.skipBlock ? : self.skipBlock();
}

-(void)setIsHidSkipBtn:(BOOL)isHidSkipBtn
{
    _isHidSkipBtn = isHidSkipBtn;
    self.skipBtn.hidden = isHidSkipBtn;
    self.skipSynopsis.hidden = isHidSkipBtn;
}

@end
