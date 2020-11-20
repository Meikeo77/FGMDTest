//
//  UIViewController+FGMD.h
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import <UIKit/UIKit.h>
#import "FGMDAutoTrackProperty.h"
#import "FGMDAutoTrackViewControllerProperty.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (FGMD) <FGMDAutoTrackProperty, FGMDAutoTrackViewControllerProperty>

@end

NS_ASSUME_NONNULL_END
