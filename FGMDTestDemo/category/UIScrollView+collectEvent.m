//
//  UIScrollView+collectEvent.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/7.
//

#import "UIScrollView+collectEvent.h"
#define GET_CLASS_CUSTOM_SEL(sel,class)  NSSelectorFromString([NSString stringWithFormat:@"%@_%@",NSStringFromClass(class),NSStringFromSelector(sel)])

@implementation UIScrollView (collectEvent)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] fg_swizzlingMethod:@selector(setDelegate:) toMethod:@selector(fgmd_setDelegate:)];
    });
}

- (void)fgmd_setDelegate:(id<UIScrollViewDelegate>)delegate {
    if ([NSStringFromClass([self class]) isEqualToString:@"UITableView"]){
        if (![self isContainSel:GET_CLASS_CUSTOM_SEL(@selector(tableView:didSelectRowAtIndexPath:),[delegate class]) inClass:[delegate class]]) {
//            [(UITableView *)self swizzling_tableViewDidSelectRowAtIndexPathInClass:delegate];
        }
    }
    [self fgmd_setDelegate:delegate];
}


@end
