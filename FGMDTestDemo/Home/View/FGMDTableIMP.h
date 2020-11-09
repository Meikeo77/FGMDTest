//
//  FGMDTableIMP.h
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import "YBHandyTableIMP.h"

NS_ASSUME_NONNULL_BEGIN

@interface FGMDTableIMP : YBHandyTableIMP
@property (nonatomic, copy) void(^didSelectRowAtIndexPath)(NSIndexPath *indexPath);

@end

NS_ASSUME_NONNULL_END
