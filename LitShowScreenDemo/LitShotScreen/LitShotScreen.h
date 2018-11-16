//
//  LitShotScreen.h
//  UITest
//
//  Created by light on 2018/11/16.
//  Copyright © 2018 Lit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LitShotScreen : NSObject


/**
 设定尺寸剪裁图片
 */
+ (UIImage *)clipImage:(UIImage *)shotView;

/**
 截图控件
 */
+ (UIImage *)customSnapshotFromView:(UIView *)inputView;

/**
 获取截屏
 */
+ (UIImage *)imageDataFromScreenShot;
@end

NS_ASSUME_NONNULL_END
