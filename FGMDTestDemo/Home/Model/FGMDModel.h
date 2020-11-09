//
//  FGMDModel.h
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FGMDModel : NSObject

@end

@interface FGMDCircleParameterModel : NSObject
///唯一标识
@property (nonatomic, copy) NSString *identifier;
///事件id
@property (nonatomic, copy) NSString *eventId;
///附加参数
@property (nonatomic, strong) NSMutableArray <NSString *> *additionalKeys;
@end

NS_ASSUME_NONNULL_END
