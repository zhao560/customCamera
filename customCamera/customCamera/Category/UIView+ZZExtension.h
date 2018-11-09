//
//  UIView+ZZExtension.h
//
//  Created by 凉凉 on 2018/3/1.
//  Copyright © 2018年 凉凉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZZExtension)
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

+(instancetype)get_viewFromXib;

+ (UIImage *)imageWithColor:(UIColor *)color;

/// 裁圆角
-(void)circleView;
-(void)circleViewByCornerRadii:(CGSize)cornerRadii;
-(void)circleViewByRoundingCorners:(UIRectCorner)corners;
-(void)circleViewByRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/**
 *改变字符串中具体某字符串的颜色
 */
+ (void)messageAction:(UILabel *_Nullable)theLab changeString:(NSString *_Nullable)change andAllColor:(UIColor *_Nullable)allColor andMarkColor:(UIColor *_Nullable)markColor andMarkFondSize:(float)fontSize;
/**
 改变字符串中多个字体的颜色
 */
+ (void)messageAction:(UILabel *_Nullable)theLab changeAry:(NSArray *_Nullable)change andAllColor:(UIColor *_Nullable)allColor andMarkColor:(UIColor *_Nullable)markColor andMarkFondSize:(float)fontSize;

/**
 *改变字符串中具体某字符串的颜色与行间距
 */
+ (void)messageAction:(UILabel *_Nullable)theLab changeString:(NSString *_Nullable)change andAllColor:(UIColor *_Nullable)allColor andMarkColor:(UIColor *_Nullable)markColor andMarkFondSize:(float)fontSize withLineSpace:(float)space;
@end
