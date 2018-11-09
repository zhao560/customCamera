//
//  ZZCustomCameraViewController.h
//  test
//
//  Created by root on 2018/11/2.
//  Copyright © 2018年 凉凉. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 自定义相机
@interface ZZCustomCameraViewController : UIViewController
/// 选择的图片
@property (nonatomic, copy) void (^selectImgBlock)(UIImage *img);

@end
