//
//  UIImage+LitShowScreen.h
//  LitShowScreenDemo
//
//  Created by light on 2018/11/19.
//  Copyright © 2018 Lit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LitShowScreen)

/**
 剪裁图片
 @param rect 需要剪裁的尺寸
 @return 剪裁后的图片
 */
- (UIImage *)lit_clipRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
