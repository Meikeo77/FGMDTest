//
//  FGMDHomeListTableViewCell.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import "FGMDHomeListTableViewCell.h"

@implementation FGMDHomeListTableCellConfig

@end

@interface FGMDHomeListTableViewCell () <YBHTableCellProtocol>
@property (nonatomic, strong) QMUILabel *cellTitle;

@end

@implementation FGMDHomeListTableViewCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
    [super didInitializeWithStyle:style];
    
    [self.contentView addSubview:self.cellTitle];
    [_cellTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(16);
        make.top.bottom.mas_equalTo(self.contentView);
    }];
}

- (void)ybht_setCellConfig:(id<YBHTableCellConfig>)config {
    FGMDHomeListTableCellConfig *cellConfig = (FGMDHomeListTableCellConfig *)config;
    _cellTitle.text = cellConfig.cellTitle;
}

+ (CGFloat) ybht_heightForCellWithConfig:(id<YBHTableCellConfig>)config reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (QMUILabel *)cellTitle {
    if (_cellTitle == nil) {
        _cellTitle = [[QMUILabel alloc] qmui_initWithFont:[UIFont systemFontOfSize:16] textColor:UIColorBlack];
    }
    return _cellTitle;
}

@end
