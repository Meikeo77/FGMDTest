//
//  FGMDAutoTrackViewControllerProperty.h
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FGMDAutoTrackViewControllerProperty <NSObject>
@property (nonatomic, copy, readonly) NSString *fgmd_screenName;
@property (nonatomic, copy, readonly) NSString *fgmd_title;
@end

NS_ASSUME_NONNULL_END
