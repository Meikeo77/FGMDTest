//
//  FGMDInfoListTableViewCell.h
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/11.
//

#import "QMUITableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FGMDInfoListTableCellConfig : YBHTableCellConfig
@property (nonatomic, copy) NSString *event;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *content;
@end

@interface FGMDInfoListTableViewCell : QMUITableViewCell

@end

NS_ASSUME_NONNULL_END
