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
        [[self class] fg_swizzlingMethod:@selector(layoutSubviews) toMethod:@selector(fgmd_layoutSubviews)];
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

@end
