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
    
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [_firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.firstView);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
}

- (void)fitstBtnAction {
    NSLog(@"点击按钮1");
}

- (UIView *)firstView {
    if (!_firstView) {
        _firstView = [UIView new];
       
    }
    return _firstView;
}

- (QMUIButton *)firstButton {
    if (!_firstButton) {
        _firstButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_firstButton setTitle:@"按钮1" forState:UIControlStateNormal];
        [_firstButton addTarget:self action:@selector(fitstBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _firstButton;
}


@end
