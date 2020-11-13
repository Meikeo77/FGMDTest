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

@property (nonatomic, copy, readonly) NSString *elementContent;  //元素名称
@end

NS_ASSUME_NONNULL_END
