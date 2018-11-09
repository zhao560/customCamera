//
//  UIButton+ZZExtension.m
//  BHJinFu
//
//  Created by 凉凉 on 2018/3/28.
//  Copyright © 2018年 z. All rights reserved.
//

#import "UIButton+ZZExtension.h"

/// 标题默认颜色
#define kItemTitleColor ([UIColor colorWithWhite:80.0 / 255.0 alpha:1.0])
/// 标题高亮颜色
#define kItemTitleHighlightedColor ([UIColor orangeColor])
/// 标题字体大小
#define kItemFontSize   14

@implementation UIButton (ZZExtension)

+ (instancetype)zz_buttonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置标题
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kItemTitleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:kItemFontSize];
    // 图片
    if (imageName != nil) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    [button sizeToFit];
    // 监听方法
    if (action != nil) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

+ (instancetype)zz_buttonWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置标题
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color ? color : [UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button sizeToFit];
    // 监听方法
    if (action != nil) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

+ (instancetype)zz_buttonWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize imageName:(NSString *)imageName backImageName:(NSString *)backImageName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置标题
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color ? color : [UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    // 图片
    if (imageName != nil) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    // 背景图片
    if (backImageName != nil) {
        [button setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    }
    return button;
}

+ (instancetype)zz_buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backImageName:(NSString *)backImageName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置标题
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor ? titleColor : [UIColor blackColor] forState:UIControlStateNormal];
    // 背景图片
    if (backImageName != nil) {
        [button setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    }
    return button;
}
@end
