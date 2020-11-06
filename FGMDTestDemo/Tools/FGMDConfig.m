//
//  FGMDConfig.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import "FGMDConfig.h"

@interface FGMDConfig ()

@end

@implementation FGMDConfig

+ (instancetype)defaultConfig {
    static FGMDConfig *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [FGMDConfig new];
    });
    return instance;
}


- (UIColor *)fgmd_randomColor {
    NSInteger aRedValue = arc4random() %255;
    NSInteger aGreenValue = arc4random() %255;
    NSInteger aBlueValue = arc4random() %255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue /255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
    return randColor;
}

@end
