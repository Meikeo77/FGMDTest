//
//  UIView+FGMD.h
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import <UIKit/UIKit.h>
#import "FGMDAutoTrackProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FGMD) <FGMDAutoTrackProperty , FGMDAutoTrackViewControllerProperty>
/// 追寻视图的类型
- (BOOL)isSuperviewFromView:(Class)viewClass;

// 在 controller 上的成员变量
- (NSString *)fgmd_controllerVariable;

//视图内容
- (NSString *)fgmd_text;

@property (nonatomic, copy, readonly) NSString *elementContent;  //元素名称
@end

NS_ASSUME_NONNULL_END
