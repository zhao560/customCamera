//
//  UIView+ZZExtension.m
//
//  Created by 凉凉 on 2018/3/1.
//  Copyright © 2018年 凉凉. All rights reserved.
//

#import "UIView+ZZExtension.h"

@implementation UIView (ZZExtension)

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

+(instancetype)get_viewFromXib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/// 裁圆角
-(void)circleView
{
    [self circleViewByRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight];
}

-(void)circleViewByCornerRadii:(CGSize)cornerRadii
{
    [self circleViewByRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:cornerRadii];
}

-(void)circleViewByRoundingCorners:(UIRectCorner)corners
{
    [self circleViewByRoundingCorners:corners cornerRadii:CGSizeMake(self.height * 0.5, self.height * 0.5)];
}

-(void)circleViewByRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii
{
    UIBezierPath *teacherPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *teacherBtnLayer = [[CAShapeLayer alloc] init];
    teacherBtnLayer.frame = self.bounds;
    teacherBtnLayer.path = teacherPath.CGPath;
    self.layer.mask = teacherBtnLayer;
}

/**
 *改变字符串中具体某字符串的颜色与行间距
 */
+ (void)messageAction:(UILabel *_Nullable)theLab changeString:(NSString *_Nullable)change andAllColor:(UIColor *_Nullable)allColor andMarkColor:(UIColor *_Nullable)markColor andMarkFondSize:(float)fontSize withLineSpace:(float)space {
    NSString *tempStr = theLab.text;
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
    [strAtt addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, [strAtt length])];
    NSRange markRange = [tempStr rangeOfString:change];
    NSMutableParagraphStyle * paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = space;
    NSDictionary *dic = @{NSParagraphStyleAttributeName:paraStyle};
    [strAtt addAttribute:NSForegroundColorAttributeName value:markColor range:markRange];
    [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:fontSize] range:markRange];
    [strAtt addAttributes:dic range:markRange];
    theLab.attributedText = strAtt;
}

/**
 *改变字符串中具体某字符串的颜色
 */
+ (void)messageAction:(UILabel *)theLab changeString:(NSString *)change andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize {
    NSString *tempStr = theLab.text;
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
    [strAtt addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, [strAtt length])];
    NSRange markRange = [tempStr rangeOfString:change];
    [strAtt addAttribute:NSForegroundColorAttributeName value:markColor range:markRange];
    [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:fontSize] range:markRange];
    theLab.attributedText = strAtt;
}

/**
 改变字符串中多个字体的颜色
 */
+ (void)messageAction:(UILabel *)theLab changeAry:(NSArray *)change andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize
{
    NSString *tempStr = theLab.text;
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
    [strAtt addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, [strAtt length])];
    for (NSString * objStr  in change)
    {
        NSRange markRange = [tempStr rangeOfString:objStr];
        [strAtt addAttribute:NSForegroundColorAttributeName value:markColor range:markRange];
        [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:fontSize] range:markRange];
    }
    
    theLab.attributedText = strAtt;
}

@end
