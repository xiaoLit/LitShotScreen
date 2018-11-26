//
//  UIView+LitShotScreen.h
//  LitShowScreenDemo
//
//  Created by light on 2018/11/19.
//  Copyright © 2018 Lit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LitShotScreen)

/**
 获取截屏
 */
+ (UIImage *)lit_screenShotImage;

/**
 剪裁view
 @param rect 需要剪裁的尺寸
 @return 剪裁后的图片
 */
- (UIImage *)lit_clipRect:(CGRect)rect;

/**
 可以将横屏截取的图片 变成竖屏显示的模式
 */
+ (UIImage *)lit_screenShotPortraitImageWithLandscapeImage;

@end

NS_ASSUME_NONNULL_END
