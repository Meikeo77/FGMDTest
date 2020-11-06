//
//  UIControl+collectEvent.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import "UIControl+collectEvent.h"

@implementation UIControl (collectEvent)

+ (void)load {
    [[self class] fg_swizzlingMethod:@selector(sendAction:to:forEvent:) toMethod:@selector(fgmd_sendAction:to:forEvent:)];
}

- (void)fgmd_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    /***进行圈选操作*/
    
    NSString *sendClassName = NSStringFromClass([self class]);
    NSString *actionName = NSStringFromSelector(action);
    NSString *targetClassName = NSStringFromClass([target class]);
    CGRect targetFrame = self.frame;
    NSLog(@"** %@ 发送 %@ 给 %@ frame:(x:%.2f, y:%.2f, w:%.2f, h:%.2f)", sendClassName, actionName, targetClassName, targetFrame.origin.x, targetFrame.origin.y, targetFrame.size.width, targetFrame.size.height);
    
    /***进行圈选操作*/
    [self fgmd_sendAction:action to:target forEvent:event];
}


- (void)fg_swizzlingMethod:(SEL)originMethod toMethod:(SEL)targetMethod {
    Class class = [self class];
    Method origin = class_getInstanceMethod(class, originMethod);
    Method target = class_getInstanceMethod(class, targetMethod);
    
    method_exchangeImplementations(origin, target);
}

@end
