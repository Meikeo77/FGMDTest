//
//  NSObject+runtime.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/7.
//

#import "NSObject+runtime.h"

@implementation NSObject (runtime)
- (void)fg_swizzlingMethod:(SEL)originMethod toMethod:(SEL)targetMethod {
    Class class = [self class];
    Method origin = class_getInstanceMethod(class, originMethod);
    Method target = class_getInstanceMethod(class, targetMethod);
    
    method_exchangeImplementations(origin, target);
}

- (BOOL)isContainSel:(SEL)sel inClass:(Class)class {
    unsigned int count;
    
    Method *methodList = class_copyMethodList(class,&count);
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSString *tempMethodString = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
        if ([tempMethodString isEqualToString:NSStringFromSelector(sel)]) {
            return YES;
        }
    }
    return NO;
}
@end
