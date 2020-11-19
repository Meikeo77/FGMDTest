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
@property (nonatomic, strong) QMUIButton *circleButton;
@end

@implementation FGMDHandleView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorMakeWithRGBA(0, 0, 0, 0.3);
        [self addSubview:self.segmentControl];
        
        [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.mas_equalTo(self).mas_offset(5);
            make.trailing.mas_equalTo(-5);
            make.height.mas_equalTo(25);
        }];
    }
    return self;
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

@end
