//
//  UILabel+ZZExtension.h
//  BHJinFu
//
//  Created by 凉凉 on 2018/3/28.
//  Copyright © 2018年 z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ZZExtension)

/// 创建 UILabel
///
/// @param title     标题
/// @param color     标题颜色
/// @param fontSize  字体大小
///
/// @return UILabel(文本水平居中)
+ (instancetype)zz_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize;

/// 创建 UILabel
///
/// @param title     标题
/// @param color     标题颜色
/// @param fontSize  字体大小
/// @param alignment 对齐方式
///
/// @return UILabel
+ (instancetype)zz_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment;

@end
