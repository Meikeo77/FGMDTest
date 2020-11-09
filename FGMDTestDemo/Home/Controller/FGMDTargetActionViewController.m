//
//  FGMDTargetActionViewController.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import "FGMDTargetActionViewController.h"

@interface FGMDTargetActionViewController ()
@property (nonatomic, strong) UIView *firstView;
@property (nonatomic, strong) QMUIButton *firstButton;
@property (nonatomic, strong) UIView *tapView;
@end

@implementation FGMDTargetActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"点击测试";
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)initSubviews {
    [super initSubviews];
    [self.view addSubview:self.firstView];
    [self.firstView addSubview:self.firstButton];
    [self.view addSubview:self.tapView];
    
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(20);
        make.trailing.mas_equalTo(-20);
        make.height.mas_equalTo(60);
    }];
    
    [_firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.firstView);
        make.size.mas_equalTo(CGSizeMake(50, 40));
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

- (void)tapAction:(UITapGestureRecognizer *)gesture {
    NSLog(@"手势点击");
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
        [_firstButton setBackgroundColor:UIColorMakeWithHex(@"#EDF5FF")];
        [_firstButton addTarget:self action:@selector(fitstBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _firstButton;
}

- (UIView *)tapView {
    if (!_tapView) {
        _tapView = [UIView new];
        _tapView.backgroundColor = self.firstView.backgroundColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_tapView addGestureRecognizer:tap];
    }
    return _tapView;
}


@end
