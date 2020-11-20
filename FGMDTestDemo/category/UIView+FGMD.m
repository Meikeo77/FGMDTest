//
//  UIView+FGMD.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import "UIView+FGMD.h"
#import "FGMDHandleView.h"
@interface UIView ()
@property (nonatomic, strong) CALayer *metricsBorderLayer;
@end

@implementation UIView (FGMD)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [[self class] fg_swizzlingMethod:@selector(layoutSubviews) toMethod:@selector(fgmd_layoutSubviews)];
    });
}


- (void)fgmd_layoutSubviews {
    [self fgmd_layoutSubviews];
    if ([FGMDConfig defaultConfig].circleOpen) {
        [self fgmd_metricsRecursiveEnable:[FGMDConfig defaultConfig].circling];
    }
}

///描边
- (void)fgmd_metricsRecursiveEnable:(BOOL)enable {
    //去除状态栏
    UIWindow *statusBar = [[UIApplication sharedApplication] valueForKey:@"_statusBarWindow"];
    if (statusBar && [self isDescendantOfView:statusBar]) {
        return;
    }
    
    //去除埋点操作栏
    if ([self isSuperviewFromView:FGMDHandleView.class]) {
        return;
    }
    
    for (UIView *subView in self.subviews) {
        [subView fgmd_metricsRecursiveEnable:enable];
    }
    
    if (enable) {
        if (!self.metricsBorderLayer) {
            CALayer *layer = [CALayer new];
            layer.borderColor = [[FGMDConfig defaultConfig] fgmd_randomColor].CGColor;
            layer.borderWidth = 0.5;
            self.metricsBorderLayer = layer;
            [self.layer addSublayer:self.metricsBorderLayer];
        }
        self.metricsBorderLayer.frame = self.bounds;
        self.metricsBorderLayer.hidden = NO;
    }else if(self.metricsBorderLayer) {
        self.metricsBorderLayer.hidden = YES;
    }
}


- (void)setMetricsBorderLayer:(CALayer *)metricsBorderLayer {
    objc_setAssociatedObject(self, @selector(metricsBorderLayer), metricsBorderLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)metricsBorderLayer {
    return objc_getAssociatedObject(self, _cmd);
}

/// 追寻视图的类型
- (BOOL)isSuperviewFromView:(Class)viewClass {
    UIView *fSuperView = self.superview;
    while (fSuperView) {
        if ([fSuperView isKindOfClass:viewClass]) {
            return YES;
        }else {
            fSuperView = fSuperView.superview;
        }
    }
    return NO;
}


- (NSString *)elementContent {
    return nil;
}

#pragma - mark FGMDAutoTrackProperty
- (NSString *)fgmd_heatMapPath {
    return [FGMDAutoTrackUtils itemHeatMapPathForResponder:self];
}

- (NSString *)fgmd_itemPath {
    NSInteger index = [FGMDAutoTrackUtils itemIndexForResponder:self];
    NSString *className = NSStringFromClass(self.class);
    return index < 0 ? className : [NSString stringWithFormat:@"%@[%ld]", className, (long)index];
}


- (NSString *)fgmd_text {
    NSString *text = nil;
    SEL titleSelector = NSSelectorFromString(@"title");
    if ([self isKindOfClass:[UILabel class]]) {
        text = ((UILabel *)self).text;
    } else if ([self isKindOfClass:[UIButton class]]) {
        text = [((UIButton *)self) titleForState:UIControlStateNormal];
    } else if ([self respondsToSelector:titleSelector]) {
        IMP titleImp = [self methodForSelector:titleSelector];
        void *(*func)(id, SEL) = (void *(*)(id, SEL))titleImp;
        id title = (__bridge id)func(self, titleSelector);
        if ([title isKindOfClass:[NSString class]]) {
            text = title;
        }
    }
    return text;
}

// 在 controller 上的成员变量
- (NSString *)fgmd_controllerVariable {
    if (![self isKindOfClass:[UIControl class]]) {
        return nil;
    }
    NSString *result = nil;
    UIResponder *responder = [self nextResponder];
    while (responder && ![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
    }
    if (responder) {
        uint count;
        Ivar *ivars = class_copyIvarList([responder class], &count);
        for (uint i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *objCType = ivar_getTypeEncoding(ivar);
            if (objCType) {
                if (objCType[0] == '@' && object_getIvar(responder, ivar) == self) {
                    result = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
                    break;
                }
            }
        }
        free(ivars);
    }
    return result;
}


- (UIViewController *)fgmd_viewController {
    
    UIViewController *viewController = [FGMDAutoTrackUtils findNextViewControllerByResponder:self];

    // 获取当前 controller 作为 screen_name
//    if ([viewController isKindOfClass:UINavigationController.class] || [viewController isKindOfClass:UIAlertController.class]) {
//        viewController = [SAAutoTrackUtils currentViewController];
//    }
    return viewController;
}
@end
