//
//  LitShotScreen.m
//  UITest
//
//  Created by light on 2018/11/16.
//  Copyright © 2018 Lit. All rights reserved.
//

#import "LitShotScreen.h"

@implementation LitShotScreen


+ (UIImage *)clipImage:(UIImage *)shotView {
    
    //上面我们获得了一个全屏的截图，下边的方法是对这个图片进行裁剪。
    CGImageRef imageRef = shotView.CGImage;
    //这里要特别注意，这里的宽度 CGImageGetWidth(imageRef) 是图片的像素宽（高度同解），所以计算截图区域时需要按比例来；
    //这里举的例子是宽高屏幕1/2位置在中心
    CGRect rect =  CGRectMake(CGImageGetWidth(imageRef)/4, CGImageGetHeight(imageRef)/2-CGImageGetWidth(imageRef)/2, CGImageGetWidth(imageRef)/2, CGImageGetWidth(imageRef)/2);//这里可以设置想要截图的区域
    
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    
    UIImage *clipImage =[[UIImage alloc] initWithCGImage:imageRefRect];
    
    return clipImage;
}


+ (UIImage *)customSnapshotFromView:(UIView *)inputView {
    UIGraphicsBeginImageContextWithOptions(inputView.frame.size, NO, 0.0);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    if ([inputView respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [inputView drawViewHierarchyInRect:inputView.bounds afterScreenUpdates:YES];
    } else {
        [inputView.layer renderInContext:context];
    }
    
    UIImage*targetImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return targetImage;
}


+ (UIImage *)screenShotImage {
    /**
     创建一个基于位图的上下文（context）,并将其设置为当前上下文(context)
     @param size 参数size为新创建的位图上下文的大小。它同时是由UIGraphicsGetImageFromCurrentImageContext函数返回的图形大小
     @param opaque 透明开关，如果图形完全不用透明，设置为YES以优化位图的存储，我们得到的图片背景将会是黑色，使用NO，表示透明，图片背景色正常
     @param scale 缩放因子 iPhone 4是2.0，其他是1.0。虽然这里可以用[UIScreen mainScreen].scale来获取，但实际上设为0后，系统就会自动设置正确的比例了
     */
    UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, NO, 0);

    //获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();

    //遍历所有窗口 用于完善处理一些多层windows显示问题
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {

        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        } else {
            //layer是不能够直接绘制的.要用渲染的方法才能够让它绘制到上下文当中。
            [window.layer renderInContext:context];
        }
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}


+ (UIImage *)screenShotPortraitImageWithLandscapeImage {
    
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = [UIScreen mainScreen].bounds.size;
    } else {
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        //保存当前上下文状态
        CGContextSaveGState(context);
        //平移绘制
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        //联合变换
        CGContextConcatCTM(context, window.transform);
        //平移绘制图片
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        //根据屏幕方向不同进行不同的变换
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        } else if (orientation == UIInterfaceOrientationLandscapeRight) {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        } else {
            [window.layer renderInContext:context];
        }
        //还原上下文状态
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
