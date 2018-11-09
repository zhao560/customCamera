//
//  UIColor+ZZExtension.h
//  BHJinFu
//
//  Created by 凉凉 on 2018/3/22.
//  Copyright © 2018年 z. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ColorHex(hexString) [UIColor colorFromHexString:hexString]

@interface UIColor (ZZExtension)

/**
 *  @author cxk
 *
 *  十六进制加透明度
 *
 *  @param hexString 颜色的十六进制
 *  @param alpha     透明度
 *
 *  @return 返回UIColor
 */
+ (instancetype)colorFromHexString:(NSString *)hexString Alpha:(CGFloat)alpha;
/**
 *  @author cxk
 *
 *  十六进制
 *
 *  @param hexString 颜色的十六进制，如“#ffffff”
 *
 *  @return 返回UIColor类型
 */
+ (instancetype)colorFromHexString:(NSString *)hexString;

/**
 *  @author cxk
 *
 *  通过传入的值装换成颜色，比如255,255,255,1
 *
 *
 *  @return 返回UIColor类型
 */
+ (instancetype)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;


@end
