//
//  UIViewController+FGMD.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import "UIViewController+FGMD.h"

@implementation UIViewController (FGMD)
#pragma - mark FGMDAutoTrackProperty
- (NSString *)fgmd_heatMapPath {
    return [FGMDAutoTrackUtils itemHeatMapPathForResponder:self];
}

- (NSString *)fgmd_itemPath {
    NSInteger index = [FGMDAutoTrackUtils itemIndexForResponder:self];
    NSString *className = NSStringFromClass(self.class);
    return index < 0 ? className : [NSString stringWithFormat:@"%@[%ld]", className, (long)index];
}


- (NSString *)sensorsdata_screenName {
    return NSStringFromClass([self class]);
}

- (NSString *)sensorsdata_title {
    __block NSString *titleViewContent = nil;
    __block NSString *controllerTitle = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        titleViewContent = self.navigationItem.titleView.elementContent;
        controllerTitle = self.navigationItem.title;
    });
    if (titleViewContent.length > 0) {
        return titleViewContent;
    }

    if (controllerTitle.length > 0) {
        return controllerTitle;
    }
    return nil;
}
@end
