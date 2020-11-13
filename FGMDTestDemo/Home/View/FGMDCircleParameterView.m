//
//  FGMDCircleParameterView.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/9.
//

#import "FGMDCircleParameterView.h"
@interface FGMDCircleParameterView()
@property (nonatomic, strong) QMUILabel *actionLabel;
@property (nonatomic, strong) UIScrollView *parameScroll;
@property (nonatomic, strong) QMUILabel *identifyLabel;  //唯一标识
@property (nonatomic, strong) QMUITextField *eventIdTextField;

@property (nonatomic, strong) QMUITextField *customerTextField;

@property (nonatomic, strong) QMUIButton *sureButton;
@property (nonatomic, strong) QMUIButton *cancelButton;
@property (nonatomic, strong) QMUIButton *deleteButton;
@end


@implementation FGMDCircleParameterView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
    
    [self addSubview:self.parameScroll];
    [self addSubview:self.sureButton];
    [self addSubview:self.cancelButton];
    [self addSubview:self.deleteButton];
    
    
    ///唯一标识
    QMUILabel *idTitle = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(16) textColor:UIColorBlack];
    idTitle.text = @"唯一标识";
    idTitle.frame = CGRectMake(16, 10, 100, 20);
    [self.parameScroll addSubview:idTitle];
    
    self.identifyLabel = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(16) textColor:UIColorBlack];
    _identifyLabel.numberOfLines = 0;
    _identifyLabel.frame = CGRectMake(16, 30, SCREEN_WIDTH - 32, 50);
    _identifyLabel.backgroundColor = UIColorWhite;
    [self.parameScroll addSubview:self.identifyLabel];

    
    ///事件ID
    QMUILabel *eventTitle = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(16) textColor:UIColorBlack];
    eventTitle.text = @"事件ID";
    eventTitle.frame = CGRectMake(16, CGRectGetMaxY(_identifyLabel.frame) + 10, 100, 20);
    [self.parameScroll addSubview:eventTitle];
    
    _eventIdTextField = [[QMUITextField alloc]init];
    _eventIdTextField.placeholder = @"请输入事件ID";
    _eventIdTextField.frame = CGRectMake(16, CGRectGetMaxY(eventTitle.frame) + 10, SCREEN_WIDTH - 32, 30);
    _eventIdTextField.backgroundColor = UIColorWhite;
    [self.parameScroll addSubview:_eventIdTextField];
    
    ///点击参数
//    QMUILabel *pageTitle = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(16) textColor:UIColorBlack];
//    pageTitle.text = @"点击参数";
//    pageTitle.frame = CGRectMake(16, CGRectGetMaxY(_eventIdTextField.frame) + 20, 80, 20);
//    [self.parameScroll addSubview:pageTitle];
//
//    UIButton *pageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [pageButton setImage:[UIImage imageNamed:@"multi_select_select_unuse"] forState:UIControlStateNormal];
//    [pageButton setImage:[UIImage imageNamed:@"multi_select_select"] forState:UIControlStateSelected];
//    pageButton.frame = CGRectMake(16, CGRectGetMaxY(pageTitle.frame) + 10, 20, 20);
//    [self.parameScroll addSubview:pageButton];
//
//    QMUILabel *pageKey = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(16) textColor:UIColorBlack];
//    pageKey.text = @"page-data";
//    pageKey.frame = CGRectMake(CGRectGetMaxX(pageButton.frame) + 10, CGRectGetMinY(pageButton.frame), 100, 20);
//    [self.parameScroll addSubview:pageKey];
        
    /// 自定义参数
    QMUILabel *additionalTitle = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(16) textColor:UIColorBlack];
    additionalTitle.text = @"自定义参数";
    additionalTitle.frame = CGRectMake(16, CGRectGetMaxY(_eventIdTextField.frame) + 20, 100, 20);
    [self.parameScroll addSubview:additionalTitle];
    
    _customerTextField = [[QMUITextField alloc]init];
    _customerTextField.placeholder = @"请输入自定义参数key";
    _customerTextField.frame = CGRectMake(16, CGRectGetMaxY(additionalTitle.frame) + 10, SCREEN_WIDTH - 32, 30);
    _customerTextField.backgroundColor = UIColorWhite;
    [self.parameScroll addSubview:_customerTextField];
    
    _parameScroll.contentSize = CGSizeMake(0, CGRectGetMaxY(_customerTextField.frame) + 30);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.cancelButton.frame = CGRectMake(10, self.frame.size.height - 58, (SCREEN_WIDTH - 40)/3, 48);
    self.deleteButton.frame = CGRectMake(CGRectGetMaxX(self.cancelButton.frame) + 10, self.frame.size.height - 58, (SCREEN_WIDTH - 40)/3, 48);
    self.sureButton.frame = CGRectMake(CGRectGetMaxX(self.deleteButton.frame) + 10, self.frame.size.height - 58, (SCREEN_WIDTH - 40)/3, 48);
    self.parameScroll.frame = CGRectMake(0, 0, self.frame.size.width, CGRectGetMinY(self.sureButton.frame));
}

- (void)sureBtnAction {
    // 按唯一标识 记入配置表
    if (_eventIdTextField.text.length > 0) {
        FGMDCircleConfigModel *configModel = [FGMDCircleConfigModel new];
        configModel.identifier = _identifyString;
        configModel.eventId = _eventIdTextField.text;
        configModel.additionalKey = _customerTextField.text;
        //记入配置表
        [[FGMDConfig defaultConfig] insertConfig:configModel];
        [[FGMDConfig defaultConfig] hideCircleParamView];
    }
}

- (void)cancelBtnAction {
    [[FGMDConfig defaultConfig] hideCircleParamView];
}

- (void)deleteBtnAction {
    if([[FGMDConfig defaultConfig] deleteConfig:self.identifyString]) {
        _eventIdTextField.text = @"";
        _customerTextField.text = @"";
    }
}

/// 唯一标识
- (void)setIdentifyString:(NSString *)identifyString {
    _identifyString = identifyString;
    _identifyLabel.text = identifyString;
    //查找配置项
    FGMDCircleConfigModel *configModel = [[FGMDConfig defaultConfig] searchForConfig:identifyString];
    if (configModel) {
        _deleteButton.enabled = YES;
        _eventIdTextField.text = configModel.eventId;
        
    }
}


- (UIScrollView *)parameScroll {
    if (!_parameScroll) {
        _parameScroll = [[UIScrollView alloc]init];
    }
    return _parameScroll;
}

- (QMUIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"确认" forState:UIControlStateNormal];
        _sureButton.tintColorAdjustsTitleAndImage = UIColorWhite;
        [_sureButton setBackgroundColor:UIColorMakeWithHex(@"#257BF4")];
        [_sureButton addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (QMUIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.tintColorAdjustsTitleAndImage = UIColorWhite;
        [_cancelButton setBackgroundColor:UIColorYellow];
        [_cancelButton addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (QMUIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        _deleteButton.tintColorAdjustsTitleAndImage = UIColorWhite;
        [_deleteButton setBackgroundColor:UIColorRed];
        _deleteButton.enabled = NO;
        [_deleteButton addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}
@end
