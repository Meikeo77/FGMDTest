//
//  FGMDHandleView.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import "FGMDHandleView.h"
#import "FGMDInfoListViewController.h"

@interface FGMDHandleView ()
@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) UITextField *viewPathField;
@property (nonatomic, strong) UITextField *logTypeField;
@property (nonatomic, strong) UITextField *subLogtypeField;
@property (nonatomic, strong) QMUIButton *sureButton;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@end

@implementation FGMDHandleView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorMakeWithRGBA(0, 0, 0, 0.3);
        [self makeSubViews];
    }
    return self;
}

- (void)makeSubViews {
    [self addSubview:self.segmentControl];
    
    [self addSubview:self.viewPathField];
    [self addSubview:self.logTypeField];
    [self addSubview:self.subLogtypeField];
    [self addSubview:self.sureButton];
    
    QMUILabel *pathTitle = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(12) textColor:UIColorWhite];
    pathTitle.text = @"viewPath";
    [self addSubview:pathTitle];
    
    QMUILabel *logTitle = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(12) textColor:UIColorWhite];
    logTitle.text = @"logType";
    [self addSubview:logTitle];
    
    QMUILabel *subLogTitle = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(12) textColor:UIColorWhite];
    subLogTitle.text = @"subLogType";
    [self addSubview:subLogTitle];
    
    
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(self).mas_offset(5);
        make.trailing.mas_equalTo(-5);
        make.height.mas_equalTo(25);
    }];
    
    [pathTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(5);
        make.top.mas_equalTo(self.segmentControl.mas_bottom).mas_offset(5);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(60);
    }];
    
    [self.viewPathField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(pathTitle.mas_trailing).mas_offset(3);
        make.trailing.mas_equalTo(self).mas_offset(-3);
        make.height.mas_offset(13);
        make.top.mas_equalTo(pathTitle.mas_top);
    }];
    
    [logTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(5);
        make.top.mas_equalTo(pathTitle.mas_bottom).mas_offset(5);
        make.height.mas_equalTo(13);
    }];
    
    [self.logTypeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(logTitle.mas_trailing).mas_offset(3);
        make.trailing.mas_equalTo(self).mas_offset(-3);
        make.height.mas_offset(13);
        make.top.mas_equalTo(logTitle.mas_top);
    }];
    
    [subLogTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(5);
        make.top.mas_equalTo(logTitle.mas_bottom).mas_offset(5);
        make.height.mas_equalTo(13);
    }];
    
    [self.subLogtypeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(subLogTitle.mas_trailing).mas_offset(3);
        make.trailing.mas_equalTo(self).mas_offset(-3);
        make.height.mas_offset(13);
        make.top.mas_equalTo(subLogTitle.mas_top);
    }];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(subLogTitle.mas_bottom).mas_offset(15);
        make.leading.mas_equalTo(10);
        make.trailing.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
}

- (void)segmentControlAction {
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
            [FGMDConfig defaultConfig].circling = NO;
            [[FGMDConfig defaultConfig] hideCheckView];
            [[UIApplication sharedApplication].keyWindow layoutSubviews];
            break;
        case 1:
            [FGMDConfig defaultConfig].circling = YES;
            [[UIApplication sharedApplication].keyWindow layoutSubviews];
            //展示选择控件
            [[FGMDConfig defaultConfig] showCheckView];
            break;
        case 2:
            // 查看埋点记录
            [FGMDConfig defaultConfig].circling = NO;
            [[UIApplication sharedApplication].keyWindow layoutSubviews];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showMDList" object:nil];
            break;
        default:
            break;
    }
}

- (void)updateViewPath:(NSString *)viewPath LogType:(NSString *)logType subLogType:(NSString *)subLogType {
    self.viewPathField.text = viewPath;
    self.logTypeField.text = logType;
    self.subLogtypeField.text = subLogType;
}

- (void)sureBtnAction {
    if (_viewPathField.text.length > 0) {
        if (_logTypeField.text.length > 0 && _subLogtypeField.text.length > 0) {
            //新增 或 刷新
            FGMDCircleConfigModel *model = [FGMDCircleConfigModel new];
            model.identifier = _viewPathField.text;
            model.logType = _logTypeField.text;
            model.subLogType = _subLogtypeField.text;
            [[FGMDConfig defaultConfig] updataConfig:model];
        }else {
            //删除
            [[FGMDConfig defaultConfig] deleteConfigWithIdentifier:_viewPathField.text];
        }
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    _left = point.x;
    _top = point.y;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.window];
    self.frame = CGRectMake(point.x-_left, point.y-_top, self.frame.size.width, self.frame.size.height);
}

#pragma mark - Getter
- (UISegmentedControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"结束",@"圈选",@"记录"]];
        [_segmentControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
        //设置选中状态下的文字颜色和字体
        [_segmentControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName: [UIColor yellowColor]} forState:UIControlStateSelected];
        [_segmentControl addTarget:self action:@selector(segmentControlAction) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}

- (UITextField *)viewPathField {
    if (!_viewPathField) {
        _viewPathField = [[UITextField alloc]init];
        _viewPathField.enabled = NO;
        _viewPathField.font = UIFontMake(12);
        _viewPathField.textColor = UIColorWhite;
        _viewPathField.borderStyle = UITextBorderStyleLine;
    }
    return _viewPathField;
}

- (UITextField *)logTypeField {
    if (!_logTypeField) {
        _logTypeField = [[UITextField alloc]init];
        _logTypeField.font = UIFontMake(12);
        _logTypeField.textColor = UIColorWhite;
        _logTypeField.borderStyle = UITextBorderStyleLine;
    }
    return _logTypeField;
}

- (UITextField *)subLogtypeField {
    if (!_subLogtypeField) {
        _subLogtypeField = [[UITextField alloc]init];
        _subLogtypeField.font = UIFontMake(12);
        _subLogtypeField.textColor = UIColorWhite;
        _subLogtypeField.borderStyle = UITextBorderStyleLine;
    }
    return _subLogtypeField;
}

- (QMUIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"确认" forState:UIControlStateNormal];
        _sureButton.tintColorAdjustsTitleAndImage = UIColorWhite;
        _sureButton.titleLabel.font = UIFontMake(12);
        [_sureButton setBackgroundColor:UIColorMakeWithHex(@"#257BF4")];
        [_sureButton addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

@end
