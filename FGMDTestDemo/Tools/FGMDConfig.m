//
//  FGMDConfig.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import "FGMDConfig.h"
#import "FGMDHandleView.h"
#import "FGMDCircleParameterView.h"

@interface FGMDConfig ()
@property (nonatomic, strong) FGMDCircleParameterView *parameView;
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *configsArray;   //埋点配置列表
@end

@implementation FGMDConfig

+ (instancetype)defaultConfig {
    static FGMDConfig *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [FGMDConfig new];
        instance.configsArray = [NSMutableArray array];
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

- (void)addHandleView {
    FGMDHandleView *handleView = [[FGMDHandleView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 130, 34, 120, 40)];
    [[UIApplication sharedApplication].keyWindow addSubview:handleView];
}

- (void)showCircleParamView {
    _parameView = [[FGMDCircleParameterView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-500, SCREEN_WIDTH, 500)];
    [[UIApplication sharedApplication].keyWindow addSubview:_parameView];
}

- (void)hideCircleParamView {
    [_parameView removeFromSuperview];
    _parameView = nil;
}

- (NSString *)getIdentifyStringFromClassName:(NSString *)className actionName:(NSString *)actionName targetName:(NSString *)targetName {
    /// 唯一标识： class-action-target
    NSString *string = [NSString stringWithFormat:@"%@-%@-%@",className, actionName,targetName];
    return string;
}


@end
