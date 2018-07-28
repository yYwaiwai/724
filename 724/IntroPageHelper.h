//
//  IntroPageHelper.h
//  724
//
//  Created by cuixi on 2018/7/27.
//  Copyright © 2018年 cuixi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntroPageHelper : NSObject
+(instancetype)shareInstance;
+(void)showIntroPageView:(NSArray<NSString *>*)imageArray;
@end
