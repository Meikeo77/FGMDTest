//
//  FGMDHandleView.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import "FGMDHandleView.h"

@interface FGMDHandleView ()
@property (nonatomic, strong) QMUIButton *circleButton;
@end

@implementation FGMDHandleView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorWhite;
        self.layer.borderColor = UIColorBlack.CGColor;
        self.layer.borderWidth = 0.5;
        
        [self addSubview:self.circleButton];
        [self.circleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.trailing.mas_equalTo(self);
            make.height.mas_equalTo(40);
        }];
    }
    return self;
}

- (void)circleBtnAction:(QMUIButton *)button {
    
    [FGMDConfig defaultConfig].circling = ![FGMDConfig defaultConfig].circling;
    [[UIApplication sharedApplication].keyWindow layoutSubviews];
}

- (QMUIButton *)circleButton {
    if (!_circleButton) {
        _circleButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_circleButton setTitle:@"圈选" forState:UIControlStateNormal];
        [_circleButton setTitleColor:UIColorGray forState:UIControlStateNormal];
        [_circleButton setBackgroundColor:UIColorYellow];
        _circleButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_circleButton addTarget:self action:@selector(circleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _circleButton;
}

@end
