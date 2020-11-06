//
//  FGMDConfig.h
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FGMDConfig : NSObject
@property (nonatomic, assign) BOOL circling;  //圈选中

+ (instancetype)defaultConfig;
///随机颜色
- (UIColor *)fgmd_randomColor;
@end

NS_ASSUME_NONNULL_END
