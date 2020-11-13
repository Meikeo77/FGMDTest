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
@property (nonatomic, strong) NSMutableArray<FGMDCircleConfigModel *> *configArray;  //配置项集合
@property (nonatomic, strong) NSMutableArray<FGMDInfoModel *> *mdListArray;  //埋点数据集合
@end

@implementation FGMDConfig

+ (instancetype)defaultConfig {
    static FGMDConfig *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [FGMDConfig new];
        instance.configArray = [NSMutableArray array];
        instance.mdListArray = [NSMutableArray array];
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

- (void)showCircleParamViewWithIdentify:(NSString *)identify {
    _parameView = [[FGMDCircleParameterView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-500, SCREEN_WIDTH, 500)];
    _parameView.identifyString = identify;
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


/// 插入新的配置项
- (void)insertConfig:(FGMDCircleConfigModel *)configModel {
    FGMDCircleConfigModel *repeatConfig = [self searchForConfig:configModel.identifier];
    if (repeatConfig) {
        [self.configArray replaceObjectAtIndex:[self.configArray indexOfObject:repeatConfig] withObject:configModel];
    }else {
        [self.configArray addObject:configModel];
    }
}

/// 读取全部的配置项
- (NSMutableArray <FGMDCircleConfigModel *> *)readAllConfigs {
    return self.configArray.mutableCopy;
}

- (BOOL)deleteConfig:(NSString *)identifier {
    FGMDCircleConfigModel *repeatConfig = [self searchForConfig:identifier];
    if (repeatConfig) {
        [self.configArray removeObject:repeatConfig];
        return YES;
    }else {
        return NO;
    }
}


/// 查找配置项
- (FGMDCircleConfigModel *)searchForConfig:(NSString *)identifier {
    FGMDCircleConfigModel *repeatConfig = nil;
    for (FGMDCircleConfigModel *configModel in self.configArray) {
        if ([configModel.identifier isEqualToString:identifier]) {
            repeatConfig = configModel;
        }
    }
    return repeatConfig;
}


/// 插入新的埋点
- (void)insertMDInfoModel:(FGMDInfoModel *)infoModel {
    [self.mdListArray addObject:infoModel];
}

/// 读取全部埋点
- (NSMutableArray <FGMDInfoModel *> *)readAllMdList {
    return self.mdListArray.mutableCopy;
}


@end
