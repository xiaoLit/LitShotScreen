//
//  UIImage+LitShowScreen.m
//  LitShowScreenDemo
//
//  Created by light on 2018/11/19.
//  Copyright © 2018 Lit. All rights reserved.
//

#import "UIImage+LitShowScreen.h"

@implementation UIImage (LitShowScreen)

/**
 将View转化成相应尺寸的image
 
 @param rect 想截出来的尺寸
 @return image
 */
- (UIImage *)lit_clipRect:(CGRect)rect {
    
    //对这个图片进行裁剪。
    CGImageRef imageRef = self.CGImage;
    //计算截图区域时需要按比例来
    CGFloat scale = [UIScreen mainScreen].scale;
    //这里可以设置想要截图的区域
    CGRect tempRect =  CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale);
    
    //是C的函数，使用CGRect的坐标都是像素
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, tempRect);
    
    UIImage *clipImage =[[UIImage alloc]initWithCGImage:imageRefRect scale:scale orientation:(UIImageOrientationUp)];
    return clipImage;
}

@end




