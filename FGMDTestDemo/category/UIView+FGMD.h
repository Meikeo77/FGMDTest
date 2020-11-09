//
//  UIView+FGMD.h
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FGMD)
/// 追寻视图的类型
- (BOOL)isSuperviewFromView:(Class)viewClass;
@end

NS_ASSUME_NONNULL_END
