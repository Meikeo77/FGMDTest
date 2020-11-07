//
//  NSObject+runtime.h
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (runtime)
/// 方法交换
- (void)fg_swizzlingMethod:(SEL)originMethod toMethod:(SEL)targetMethod;

/// 校验类是否有对应sel
- (BOOL)isContainSel:(SEL)sel inClass:(Class)class;
@end

NS_ASSUME_NONNULL_END
