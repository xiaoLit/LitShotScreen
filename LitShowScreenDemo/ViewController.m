//
//  ViewController.m
//  LitShowScreenDemo
//
//  Created by light on 2018/11/16.
//  Copyright © 2018 Lit. All rights reserved.
//

//屏幕宽高
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"

//Category
#import "UIView+LitShotScreen.h"
#import "UIImage+LitShowScreen.h"



@interface ViewController ()

@end

@implementation ViewController
{
    UILabel *_lab;
    UIView *_backgroundView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initNotification];
    
    [self initUI];
}


/**
 注册截屏通知
 */
- (void)initNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getScreenShot:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}

- (void)initUI {
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:lab];
    lab.text = @"我是label";
    [lab setTextColor:[UIColor blueColor]];
    [lab setBackgroundColor: [UIColor blackColor]];
    _lab = lab;
    lab.layer.cornerRadius = 10;
    lab.clipsToBounds = YES;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
    [btn setTitle:@"我是Btn" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(ClickBtn) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 10;
}

/**
 按钮点击
 */
- (void)ClickBtn {
    
    //获取lab的截图
    UIImage *image = [_lab lit_clipRect:_lab.bounds];
    //展示图片
    [self showScreenShotImage:image];
}

/**
 通知回调
 */
- (void)getScreenShot:(NSNotification *)notification{
    NSLog(@"%@",notification);
    UIApplication *app = notification.object;
    if ([app isEqual:[UIApplication sharedApplication]]) {
        NSLog(@"same");
    }
    
    //获取屏幕的截图
    UIImage *image = [UIView lit_screenShotImage];
    //展示图片
    [self showScreenShotImage:image];
}


/**
 展示截图
 */
- (void)showScreenShotImage:(UIImage *)showImage {
    
    //灰色背景
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backgroundView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    _backgroundView = backgroundView;
    
    //获取截屏图片
    UIImage *image = showImage;
    //效果放缩比例
    CGFloat scale = 0.8;
    //显示图片
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(0, 0, image.size.width/scale, image.size.height/scale);
    imageView.center = backgroundView.center;
    [backgroundView addSubview:imageView];
    
    //分享按钮
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5,SCREEN_HEIGHT,SCREEN_WIDTH/5,50)];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    shareBtn.backgroundColor = [UIColor whiteColor];
    [shareBtn addTarget:self action:@selector(clickShareBtn) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:shareBtn];
    shareBtn.layer.cornerRadius = 10;

    //取消按钮
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5 *3,SCREEN_HEIGHT,SCREEN_WIDTH/5,50)];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [cancelBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:cancelBtn];
    cancelBtn.layer.cornerRadius = 10;

    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:backgroundView];
    
    [UIView animateWithDuration:1 animations:^{
        imageView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        shareBtn.transform = CGAffineTransformMakeTranslation(0, - 60);
        cancelBtn.transform = CGAffineTransformMakeTranslation(0, - 60);
    }];
}


-(void)clickShareBtn{
    NSLog(@"点击了分享");
}


- (void)clickCancelBtn {
    
    NSLog(@"点击了取消");
    
    [_backgroundView removeFromSuperview];

}
@end
