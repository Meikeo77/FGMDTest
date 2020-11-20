//
//  FGMDAutoTrackUtils.h
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FGMDAutoTrackUtils : NSObject

/**
通过响应链找到 对象的点击图路径

@param responder 响应链中的对象，可以是 UIView 或者 UIViewController
@return 路径
*/
+ (NSString *)itemHeatMapPathForResponder:(UIResponder *)responder;
/**
 找到 view 的路径数组

 @param view 需要获取路径的 view
 @return 路径数组
 */
+ (NSArray<NSString *> *)viewPathsForView:(UIView <FGMDAutoTrackProperty>*)view;

/**
 通过响应链找到 对象的序号

 @param responder 响应链中的对象，可以是 UIView 或者 UIViewController
 @return 路径
 */
+ (NSInteger )itemIndexForResponder:(UIResponder *)responder;


/**
 获取 view 的路径字符串

 @param view 需要获取路径的 view
 @param viewController view 所在的 viewController
 @return 路径字符串
 */
+ (nullable NSString *)viewPathForView:(UIView *)view atViewController:(UIViewController *)viewController;

+ (UIViewController *)findNextViewControllerByResponder:(UIResponder *)responder;

// 获取对象的唯一标识
+ (NSString *)getViewIdentifierWithObject:(UIView <FGMDAutoTrackProperty> *)object;
@end

NS_ASSUME_NONNULL_END
