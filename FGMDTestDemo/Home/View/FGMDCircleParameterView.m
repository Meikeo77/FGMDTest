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
@property (nonatomic, strong) QMUIButton *sureButton;
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
    
    
    self.identifyLabel = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(16) textColor:UIColorBlack];
    _identifyLabel.numberOfLines = 0;
    _identifyLabel.frame = CGRectMake(16, 16, SCREEN_WIDTH - 32, 50);
    _identifyLabel.backgroundColor = UIColorWhite;
    [self.parameScroll addSubview:self.identifyLabel];

    
    /// 事件ID
    QMUILabel *eventTitle = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(16) textColor:UIColorBlack];
    eventTitle.text = @"事件ID";
    eventTitle.frame = CGRectMake(16, CGRectGetMaxY(_identifyLabel.frame) + 10, 100, 20);
    [self.parameScroll addSubview:eventTitle];
    
    _eventIdTextField = [[QMUITextField alloc]init];
    _eventIdTextField.frame = CGRectMake(16, CGRectGetMaxY(eventTitle.frame) + 10, SCREEN_WIDTH - 32, 30);
    _eventIdTextField.backgroundColor = UIColorWhite;
    [self.parameScroll addSubview:_eventIdTextField];
    
    /// 页面参数
    QMUILabel *pageTitle = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(16) textColor:UIColorBlack];
    pageTitle.text = @"页面参数";
    pageTitle.frame = CGRectMake(16, CGRectGetMaxY(_eventIdTextField.frame) + 20, 80, 20);
    [self.parameScroll addSubview:pageTitle];
    
    UIButton *pageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pageButton setImage:[UIImage imageNamed:@"multi_select_select_unuse"] forState:UIControlStateNormal];
    [pageButton setImage:[UIImage imageNamed:@"multi_select_select"] forState:UIControlStateSelected];
    pageButton.frame = CGRectMake(16, CGRectGetMaxY(pageTitle.frame) + 10, 20, 20);
    [self.parameScroll addSubview:pageButton];
    
    QMUILabel *pageKey = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(16) textColor:UIColorBlack];
    pageKey.text = @"page-data";
    pageKey.frame = CGRectMake(CGRectGetMaxX(pageButton.frame) + 10, CGRectGetMinY(pageButton.frame), 100, 20);
    [self.parameScroll addSubview:pageKey];
    
    
    /// 事件参数
    
    
    /// 自定义参数
    QMUILabel *additionalTitle = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(16) textColor:UIColorBlack];
    additionalTitle.text = @"自定义参数";
    additionalTitle.frame = CGRectMake(16, CGRectGetMaxY(pageButton.frame) + 20, 100, 20);
    [self.parameScroll addSubview:additionalTitle];
    
    _parameScroll.contentSize = CGSizeMake(0, CGRectGetMaxY(additionalTitle.frame) + 30);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.sureButton.frame = CGRectMake(16, self.frame.size.height - 58, self.frame.size.width - 32, 48);
    self.parameScroll.frame = CGRectMake(0, 0, self.frame.size.width, CGRectGetMinY(self.sureButton.frame));
}

- (void)sureBtnAction {
    // 按唯一标识 记入配置表
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
@end
