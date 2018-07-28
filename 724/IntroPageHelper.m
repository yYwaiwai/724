//
//  IntroPageHelper.m
//  724
//
//  Created by cuixi on 2018/7/27.
//  Copyright © 2018年 cuixi. All rights reserved.
//

#import "IntroPageHelper.h"
#import "IntroPageView.h"

#define H_Width [IntroPageHelper shareInstance].introPageView.frame.size.width
#define H_Height [IntroPageHelper shareInstance].introPageView.frame.size.height

@interface IntroPageHelper()

@property (nonatomic,weak) UIWindow *currentWindow;
@property (nonatomic,strong) IntroPageView *introPageView;

@end

@implementation IntroPageHelper

+(instancetype)shareInstance{
    static IntroPageHelper *HelperShareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HelperShareInstance = [[IntroPageHelper alloc]init];
    });
    return HelperShareInstance;
}

+(void)showIntroPageView:(NSArray<NSString *> *)imageArray{
    if (![IntroPageHelper shareInstance].introPageView) {
        [IntroPageHelper shareInstance].introPageView = [IntroPageView pageWithFrame:[UIScreen mainScreen].bounds images:imageArray];
    }
    [IntroPageHelper shareInstance].currentWindow = [UIApplication sharedApplication].keyWindow;
    [[IntroPageHelper shareInstance].currentWindow addSubview:[IntroPageHelper shareInstance].introPageView];
    [[IntroPageHelper shareInstance].currentWindow bringSubviewToFront:[IntroPageHelper shareInstance].introPageView];
}

@end
