//
//  ZZCustomCameraControlView.h
//  YouAiXue
//
//  Created by root on 2018/11/6.
//  Copyright © 2018年 凉凉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZCustomCameraControlView : UIView
/// 拍照
@property (nonatomic, copy) void (^takeBlock)(void);
/// 打开相册
@property (nonatomic, copy) void (^openPhotoBlock)(void);
/// 跳过
@property (nonatomic, copy) void (^skipBlock)(void);
/// 关闭
@property (nonatomic, copy) void (^closeBlock)(void);
/// 隐藏跳过按钮
@property (nonatomic, assign) BOOL isHidSkipBtn;

@end
