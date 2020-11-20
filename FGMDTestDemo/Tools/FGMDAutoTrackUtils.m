//
//  FGMDAutoTrackUtils.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/20.
//

#import "FGMDAutoTrackUtils.h"

@implementation FGMDAutoTrackUtils
+ (NSArray<NSString *> *)viewPathsForView:(UIView <FGMDAutoTrackProperty>*)view {
    NSMutableArray *viewPathArray = [NSMutableArray array];
    do { // 遍历 view 层级 路径
        if (view.fgmd_heatMapPath) {
            [viewPathArray addObject:view.fgmd_heatMapPath];
        }
    } while ((view = (id)view.nextResponder) && [view isKindOfClass:UIView.class] && ![view isKindOfClass:UIWindow.class]);

    if ([view isKindOfClass:UIViewController.class]) {
        // 遍历 controller 层 路径
        [viewPathArray addObjectsFromArray:[self viewPathsForViewController:(UIViewController<FGMDAutoTrackProperty> *)view]];
    }
    return viewPathArray;
}

+ (NSArray<NSString *> *)viewPathsForViewController:(UIViewController<FGMDAutoTrackProperty> *)viewController {
    NSMutableArray *viewPaths = [NSMutableArray array];
    do {
        [viewPaths addObject:viewController.fgmd_heatMapPath];
        viewController = (UIViewController<FGMDAutoTrackProperty> *)viewController.parentViewController;
    } while (viewController);

    UIViewController<FGMDAutoTrackProperty> *vc = (UIViewController<FGMDAutoTrackProperty> *)viewController.presentingViewController;
    if ([vc conformsToProtocol:@protocol(FGMDAutoTrackProperty)]) {
        [viewPaths addObjectsFromArray:[self viewPathsForViewController:vc]];
    }
    return viewPaths;
}

+ (NSString *)itemHeatMapPathForResponder:(UIResponder *)responder {
    NSString *classString = NSStringFromClass(responder.class);

    NSArray *subResponder = nil;
    if ([responder isKindOfClass:UIView.class]) {
        UIResponder *next = [responder nextResponder];
        if ([next isKindOfClass:UIView.class]) {
            subResponder = [(UIView *)next subviews];
        }
    } else if ([responder isKindOfClass:UIViewController.class]) {
        subResponder = [(UIViewController *)responder parentViewController].childViewControllers;
    }

    NSInteger count = 0;
    NSInteger index = -1;
    for (UIResponder *res in subResponder) {
        if ([classString isEqualToString:NSStringFromClass(res.class)]) {
            count++;
        }
        if (res == responder) {
            index = count - 1;
        }
    }
    return count <= 1 ? classString : [NSString stringWithFormat:@"%@[%ld]", classString, (long)index];
}

+ (NSInteger)itemIndexForResponder:(UIResponder *)responder {
    NSString *classString = NSStringFromClass(responder.class);
    NSArray *subResponder = nil;
    if ([responder isKindOfClass:UIView.class]) {
        UIResponder *next = [responder nextResponder];
        if ([next isKindOfClass:UISegmentedControl.class]) {
            // UISegmentedControl 点击之后，subviews 顺序会变化，需要根据坐标排序才能匹配正确
            UISegmentedControl *segmentedControl = (UISegmentedControl *)next;
            NSArray <UIView *> *subViews = segmentedControl.subviews;
            subResponder = [subViews sortedArrayUsingComparator:^NSComparisonResult (UIView *obj1, UIView *obj2) {
                if (obj1.frame.origin.x > obj2.frame.origin.x) {
                    return NSOrderedDescending;
                } else {
                    return NSOrderedAscending;
                }
            }];
        } else if ([next isKindOfClass:UIView.class]) {
            subResponder = [(UIView *)next subviews];
        }
    } else if ([responder isKindOfClass:UIViewController.class]) {
        subResponder = [(UIViewController *)responder parentViewController].childViewControllers;
    }

    NSInteger count = 0;
    NSInteger index = -1;
    for (UIResponder *res in subResponder) {
        if ([classString isEqualToString:NSStringFromClass(res.class)]) {
            count++;
        }
        if (res == responder) {
            index = count - 1;
        }
    }
    // 单个 UIViewController 拼接路径，不需要序号
    if ([responder isKindOfClass:UIViewController.class] && ![responder isKindOfClass:UIAlertController.class] && count == 1) {
        index = -1;
    }
    return index;
}

+ (UIViewController *)findNextViewControllerByResponder:(UIResponder *)responder {
    UIResponder *next = [responder nextResponder];
    do {
        if ([next isKindOfClass:UIViewController.class]) {
            UIViewController *vc = (UIViewController *)next;
            if ([vc isKindOfClass:UINavigationController.class]) {
                next = [(UINavigationController *)vc topViewController];
                break;
            } else if ([vc isKindOfClass:UITabBarController.class]) {
                next = [(UITabBarController *)vc selectedViewController];
                break;
            }
            UIViewController *parentVC = vc.parentViewController;
            if (parentVC) {
                if ([parentVC isKindOfClass:UINavigationController.class] ||
                    [parentVC isKindOfClass:UITabBarController.class] ||
                    [parentVC isKindOfClass:UIPageViewController.class] ||
                    [parentVC isKindOfClass:UISplitViewController.class]) {
                    break;
                }
            } else {
                break;
            }
        }
    } while ((next = next.nextResponder));
    return [next isKindOfClass:UIViewController.class] ? (UIViewController *)next : nil;
}

+ (nullable NSString *)viewPathForView:(UIView *)view atViewController:(UIViewController *)viewController {

    NSArray *viewPaths = [[[self viewPathsForView:view] reverseObjectEnumerator] allObjects];
    NSString *viewPath = [viewPaths componentsJoinedByString:@"/"];
    return viewPath;
}

+ (NSString *)getViewIdentifierWithObject:(UIView <FGMDAutoTrackProperty> *)object {
    NSString *identifier = @"";
    if ([object isKindOfClass:[UIButton class]] || [object isKindOfClass:[UIView class]]) {
        UIViewController<FGMDAutoTrackViewControllerProperty> *viewController =  object.fgmd_viewController;
        NSString *path = [FGMDAutoTrackUtils viewPathForView:object atViewController:viewController];
        identifier = [NSString stringWithFormat:@"%@/%@", path, object.fgmd_text];
    }
    return identifier;
}
@end
