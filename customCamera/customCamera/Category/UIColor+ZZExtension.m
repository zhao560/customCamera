//
//  UIColor+ZZExtension.m
//  BHJinFu
//
//  Created by 凉凉 on 2018/3/22.
//  Copyright © 2018年 z. All rights reserved.
//

#import "UIColor+ZZExtension.h"

@implementation UIColor (ZZExtension)

+ (instancetype)colorFromHexString:(NSString *)hexString Alpha:(CGFloat)alpha
{
    if (hexString.length != 7) {
        return [UIColor whiteColor];
    }
    
    NSRange range = NSMakeRange(1, 2);
    range.location = 1;
    NSString *rStr = [hexString substringWithRange:range];
    range.location = 3;
    NSString *gStr = [hexString substringWithRange:range];
    range.location = 5;
    NSString *bStr = [hexString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rStr] scanHexInt:&r];
    [[NSScanner scannerWithString:gStr] scanHexInt:&g];
    [[NSScanner scannerWithString:bStr] scanHexInt:&b];
    
    return [UIColor colorWithRed:r / 255.0
                           green:g / 255.0
                            blue:b / 255.0
                           alpha:alpha];
}
//根据返回的16进制数据直接加＃赋值
+ (instancetype)colorFromHexString:(NSString *)hexString
{
    return [self colorFromHexString:hexString Alpha:1.0];
}
//通过返回数据直接进行计算
+ (instancetype)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha
{
    return [[self class] colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}


@end
