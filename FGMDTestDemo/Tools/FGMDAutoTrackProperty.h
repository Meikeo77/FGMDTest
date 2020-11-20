//
//  FGMDAutoTrackProperty.h
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/20.
//

#import <Foundation/Foundation.h>
#import "FGMDAutoTrackViewControllerProperty.h"
NS_ASSUME_NONNULL_BEGIN

@protocol FGMDAutoTrackProperty <NSObject>
/// $AppClick 某个元素的相对路径，拼接 $element_path，用于可视化全埋点
@property (nonatomic, copy, readonly) NSString *fgmd_itemPath;

/// $AppClick 某个元素的相对路径，拼接 $element_selector，用于点击图
@property (nonatomic, copy, readonly) NSString *fgmd_heatMapPath;

/// 获取 view 所在的 viewController，或者当前的 viewController
@property (nonatomic, readonly) UIViewController<FGMDAutoTrackViewControllerProperty> *fgmd_viewController;

@end

NS_ASSUME_NONNULL_END
