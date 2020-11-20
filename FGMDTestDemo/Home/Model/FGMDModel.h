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
@property (nonatomic, copy) NSString *logType;
@property (nonatomic, copy) NSString *subLogType;
@end

@interface FGMDInfoModel : NSObject
/// 事件id
@property (nonatomic, copy) NSString *eventId;
@property (nonatomic, copy) NSString *logType;
@property (nonatomic, copy) NSString *subLogType;
@property (nonatomic, copy) NSString *time;

@end

NS_ASSUME_NONNULL_END
