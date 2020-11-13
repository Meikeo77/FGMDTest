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

@interface FGMDCircleConfigModel : NSObject
///唯一标识
@property (nonatomic, copy) NSString *identifier;
///事件id
@property (nonatomic, copy) NSString *eventId;
///附加参数
@property (nonatomic, copy) NSString *additionalKey;
@end

@interface FGMDInfoModel : NSObject
/// 事件id
@property (nonatomic, copy) NSString *eventId;
/// 埋点内容
@property (nonatomic, copy) NSString *content;
/// 时间
@property (nonatomic, copy) NSString *time;
/// 附加内容
@property (nonatomic, copy) NSString *addition;
@end

NS_ASSUME_NONNULL_END
