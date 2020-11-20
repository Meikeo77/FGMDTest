//
//  FGMDTargetActionViewController.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import "FGMDTargetActionViewController.h"
#import "FGMDInfoListViewController.h"

@interface FGMDTargetActionViewController ()
@property (nonatomic, strong) UIView *firstView;
@property (nonatomic, strong) QMUIButton *firstButton;
@property (nonatomic, strong) QMUIButton *secondButton;
@property (nonatomic, strong) UIView *tapView;
@end

@implementation FGMDTargetActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"点击测试";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMDListAction) name:@"showMDList" object:nil];
}

- (void)initSubviews {
    [super initSubviews];
    [self.view addSubview:self.firstView];
    [self.firstView addSubview:self.firstButton];
    [self.firstView addSubview:self.secondButton];
    [self.view addSubview:self.tapView];
    
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(20);
        make.trailing.mas_equalTo(-20);
        make.height.mas_equalTo(60);
    }];
    
    [_firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.firstView);
        make.size.mas_equalTo(CGSizeMake(50, 40));
        make.leading.mas_equalTo(self.firstView).mas_offset(20);
    }];
    
    [_secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 40));
        make.centerY.mas_equalTo(self.firstView);
        make.leading.mas_equalTo(_firstButton.mas_trailing).mas_offset(20);
    }];
    
    [_tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(20);
        make.trailing.mas_offset(-20);
        make.height.mas_equalTo(_firstView.mas_height);
        make.top.mas_equalTo(_firstView.mas_bottom).mas_offset(10);
    }];
}

- (void)fitstBtnAction {
    NSLog(@"点击按钮1");
}

- (void)secondBtnAction {
    NSLog(@"点击按钮2");
}

- (void)tapAction:(UITapGestureRecognizer *)gesture {
    NSLog(@"手势点击");
}

- (void)showMDListAction {
    FGMDInfoListViewController *vc = [[FGMDInfoListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)firstView {
    if (!_firstView) {
        _firstView = [UIView new];
        _firstView.backgroundColor = UIColorFromRGBA(0xF7F7F7,1.0);
    }
    return _firstView;
}

- (QMUIButton *)firstButton {
    if (!_firstButton) {
        _firstButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_firstButton setTitle:@"按钮1" forState:UIControlStateNormal];
        [_firstButton setBackgroundColor:UIColorMakeWithHex(@"#257BF4")];
        [_firstButton setTitleColor:UIColorWhite forState:UIControlStateNormal];
        [_firstButton addTarget:self action:@selector(fitstBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _firstButton;
}

- (QMUIButton *)secondButton {
    if (!_secondButton) {
        _secondButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_secondButton setTitle:@"按钮2" forState:UIControlStateNormal];
        [_secondButton setBackgroundColor:UIColorMakeWithHex(@"#257BF4")];
        [_secondButton setTitleColor:UIColorWhite forState:UIControlStateNormal];
        [_secondButton addTarget:self action:@selector(secondBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _secondButton;
}


- (UIView *)tapView {
    if (!_tapView) {
        _tapView = [UIView new];
        _tapView.backgroundColor = self.firstView.backgroundColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_tapView addGestureRecognizer:tap];
        
        QMUILabel *tapLabel = [[QMUILabel alloc] qmui_initWithFont:UIFontMake(13) textColor:UIColorBlack];
        tapLabel.textAlignment = NSTextAlignmentCenter;
        [_tapView addSubview:tapLabel];
        tapLabel.text = @"手势点击事件";
        [tapLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(_tapView.center);
        }];
    }
    return _tapView;
}


@end
