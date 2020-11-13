//
//  FGMDInfoListTableViewCell.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/11.
//

#import "FGMDInfoListTableViewCell.h"
@implementation FGMDInfoListTableCellConfig

@end

@interface FGMDInfoListTableViewCell()<YBHTableCellProtocol>
@property (nonatomic, strong) QMUILabel *titleLabel;
@property (nonatomic, strong) QMUILabel *contentLabel;
@property (nonatomic, strong) QMUILabel *timeLabel;
@end

@implementation FGMDInfoListTableViewCell
- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
    [super didInitializeWithStyle:style];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.timeLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(16);
        make.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(16);
        make.top.mas_equalTo(_titleLabel.mas_bottom).mas_offset(5);
        make.height.mas_equalTo(20);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(16);
        make.top.mas_equalTo(_contentLabel.mas_bottom).mas_offset(5);
        make.height.mas_equalTo(20);
    }];
}

- (void)ybht_setCellConfig:(id<YBHTableCellConfig>)config {
    FGMDInfoListTableCellConfig *cellConfig = (FGMDInfoListTableCellConfig *)config;
    _titleLabel.text = cellConfig.event;
    _contentLabel.text = cellConfig.content;
    _timeLabel.text = cellConfig.time;
}

+ (CGFloat) ybht_heightForCellWithConfig:(id<YBHTableCellConfig>)config reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (QMUILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[QMUILabel alloc] qmui_initWithFont:[UIFont systemFontOfSize:14] textColor:UIColorBlack];
    }
    return _titleLabel;
}

- (QMUILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[QMUILabel alloc] qmui_initWithFont:[UIFont systemFontOfSize:14] textColor:UIColorBlack];
    }
    return _contentLabel;
}

- (QMUILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[QMUILabel alloc] qmui_initWithFont:[UIFont systemFontOfSize:12] textColor:UIColorBlack];
    }
    return _timeLabel;
}



@end
