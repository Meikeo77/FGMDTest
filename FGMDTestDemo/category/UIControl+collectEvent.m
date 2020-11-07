//
//  UIControl+collectEvent.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import "UIControl+collectEvent.h"

@implementation UIControl (collectEvent)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] fg_swizzlingMethod:@selector(sendAction:to:forEvent:) toMethod:@selector(fgmd_sendAction:to:forEvent:)];
    });
}

- (void)fgmd_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if ([FGMDConfig defaultConfig].circling) {
        /***进行圈选操作*/
        NSString *sendClassName = NSStringFromClass([self class]);
        NSString *actionName = NSStringFromSelector(action);
        NSString *targetClassName = NSStringFromClass([target class]);
        CGRect targetFrame = self.frame;
        NSLog(@"** %@ 发送 %@ 给 %@ frame:(x:%.2f, y:%.2f, w:%.2f, h:%.2f)", sendClassName, actionName, targetClassName, targetFrame.origin.x, targetFrame.origin.y, targetFrame.size.width, targetFrame.size.height);
        /***进行圈选操作*/
        
    }else {
       
        [self fgmd_sendAction:action to:target forEvent:event];
    }
}

@end
