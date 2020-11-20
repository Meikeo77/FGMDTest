//
//  FGMDConfig.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import "FGMDConfig.h"
#import "FGMDHandleView.h"
#import "FGMDCheckView.h"

@interface FGMDConfig ()
@property (nonatomic, strong) NSMutableArray<FGMDCircleConfigModel *> *configArray;  //配置项集合
@property (nonatomic, strong) NSMutableArray<FGMDInfoModel *> *mdListArray;  //埋点数据集合

@property (nonatomic, strong) FGMDCheckView *viewCheckView;
@property (nonatomic, strong) FGMDHandleView *handleView;

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

- (void)showHandleView {
    _handleView = [[FGMDHandleView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 230)/2, (SCREEN_HEIGHT - 130)/2, 230, 130)];
    [[UIApplication sharedApplication].keyWindow addSubview:_handleView];
}

- (void)updateViewPath:(NSString *)viewPath LogType:(NSString *)logType subLogType:(NSString *)subLogType {
    [_handleView updateViewPath:viewPath LogType:logType subLogType:subLogType];
}

/// 更新配置项
- (void)updataConfig:(FGMDCircleConfigModel *)configModel {
    FGMDCircleConfigModel *repeatConfig = [self searchForConfigWithIdentifier:configModel.identifier];
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

- (BOOL)deleteConfigWithIdentifier:(NSString *)identifier {
    FGMDCircleConfigModel *repeatConfig = [self searchForConfigWithIdentifier:identifier];
    if (repeatConfig) {
        [self.configArray removeObject:repeatConfig];
        return YES;
    }else {
        return NO;
    }
}


/// 查找配置项
- (FGMDCircleConfigModel *)searchForConfigWithIdentifier:(NSString *)identifier {
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


/// 显示checkView
- (void)showCheckView{
    if (!_viewCheckView) {
        _viewCheckView = [[FGMDCheckView alloc] init];
        _viewCheckView.hidden = YES;
        UIWindow *delegateWindow = [[UIApplication sharedApplication].delegate window];
        [delegateWindow addSubview:_viewCheckView];
    }
    [_viewCheckView show];
}

- (void)hideCheckView{
    [_viewCheckView hide];
}


@end
