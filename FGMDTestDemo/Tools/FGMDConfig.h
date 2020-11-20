//
//  FGMDConfig.h
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import <Foundation/Foundation.h>
#import "FGMDModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FGMDConfig : NSObject
@property (nonatomic, assign) BOOL circleOpen;  //圈选功能开启
@property (nonatomic, assign) BOOL circling;  //圈选中


+ (instancetype)defaultConfig;
///随机颜色
- (UIColor *)fgmd_randomColor;
///圈选控制栏
- (void)showHandleView;
- (void)updateViewPath:(NSString *)viewPath LogType:(NSString *)logType subLogType:(NSString *)subLogType;


/// 插入新的配置项
- (void)updataConfig:(FGMDCircleConfigModel *)configModel;
/// 删除配置
- (BOOL)deleteConfigWithIdentifier:(NSString *)identifier;
/// 读取全部的配置项
- (NSArray <FGMDCircleConfigModel *> *)readAllConfigs;
/// 查找配置项
- (FGMDCircleConfigModel *)searchForConfigWithIdentifier:(NSString *)identifier;



/// 插入新的埋点
- (void)insertMDInfoModel:(FGMDInfoModel *)infoModel;
/// 读取全部埋点
- (NSMutableArray <FGMDInfoModel *> *)readAllMdList;

- (void)showCheckView;

- (void)hideCheckView;

@end

NS_ASSUME_NONNULL_END
