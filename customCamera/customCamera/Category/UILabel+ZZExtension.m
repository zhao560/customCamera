//
//  UILabel+ZZExtension.m
//  BHJinFu
//
//  Created by 凉凉 on 2018/3/28.
//  Copyright © 2018年 z. All rights reserved.
//

#import "UILabel+ZZExtension.h"

@implementation UILabel (ZZExtension)

+ (instancetype)zz_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize
{
    color = color ? color : [UIColor blackColor];
    return [self zz_labelWithTitle:title color:color fontSize:fontSize alignment:NSTextAlignmentCenter];
}

+ (instancetype)zz_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = color = color ? color : [UIColor blackColor];;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = alignment;
    return label;
}

@end
