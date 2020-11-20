//
//  FGMDCheckView.m
//  FGMDTestDemo
//
//  Created by MiaoYe on 2020/11/20.
//

#import "FGMDCheckView.h"
static CGFloat const kViewCheckSize = 62;

@interface FGMDCheckView()
@property (nonatomic, strong) UIView *viewBound;//当前需要探测的view的边框

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, strong) NSMutableArray *arrViewHit;
@end

@implementation FGMDCheckView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake((SCREEN_WIDTH - kViewCheckSize)/2, (SCREEN_HEIGHT - kViewCheckSize)/2, kViewCheckSize, kViewCheckSize);
        self.backgroundColor = UIColorClear;
        self.layer.zPosition = FLT_MAX;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.image = [UIImage imageNamed:@"doraemon_visual"];
        [self addSubview:imageView];
        
        _arrViewHit = [[NSMutableArray alloc] initWithCapacity:30];
        
        _viewBound = [[UIView alloc] init];
        _viewBound.layer.masksToBounds = YES;
        _viewBound.layer.borderWidth = 2.;
        _viewBound.layer.borderColor = UIColorMakeWithHex(@"#CC3A4B").CGColor;
        _viewBound.layer.zPosition = FLT_MAX;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    _left = point.x;
    _top = point.y;
    CGPoint topPoint = [touch locationInView:self.window];
    UIView *view = [self topView:self.window Point:topPoint];
    CGRect frame = [self.window convertRect:view.bounds fromView:view];
    _viewBound.frame = frame;
    [self.window addSubview:_viewBound];
    [self.window bringSubviewToFront:self];
    
    // _infoWindow.hidden = NO;
//    _infoWindow.infoAttributedText = [self viewInfo:view];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.window];
    self.frame = CGRectMake(point.x-_left, point.y-_top, self.frame.size.width, self.frame.size.height);
    
    CGPoint topPoint = [touch locationInView:self.window];
    UIView *view = [self topView:self.window Point:topPoint];
    CGRect frame = [self.window convertRect:view.bounds fromView:view];
    _viewBound.frame = frame;
    // _infoWindow.hidden = NO;
//    _infoWindow.infoAttributedText = [self viewInfo:view];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.window];
    self.frame = CGRectMake(point.x-_left, point.y-_top, self.frame.size.width, self.frame.size.height);
    
    CGPoint topPoint = [touch locationInView:self.window];
    UIView *view = [self topView:self.window Point:topPoint];
    
    NSString *identifier = [FGMDAutoTrackUtils getViewIdentifierWithObject:view];
    FGMDCircleConfigModel *configModel = [[FGMDConfig defaultConfig] searchForConfigWithIdentifier:identifier];
    [[FGMDConfig defaultConfig] updateViewPath:identifier LogType:configModel.logType subLogType:configModel.subLogType];
}

- (UIView*)topView:(UIView*)view Point:(CGPoint) point{
    [_arrViewHit removeAllObjects];
    [self hitTest:view Point:point];
    UIView *viewTop=[_arrViewHit lastObject];
    [_arrViewHit removeAllObjects];
    return viewTop;
}

- (void)hitTest:(UIView*)view Point:(CGPoint) point{
    if([view isKindOfClass:[UIScrollView class]])
    {
        point.x+=((UIScrollView*)view).contentOffset.x;
        point.y+=((UIScrollView*)view).contentOffset.y;
    }
    if ([view pointInside:point withEvent:nil] &&
        (!view.hidden) &&
        (view.alpha >= 0.01f) && (view!=_viewBound) && ![view isDescendantOfView:self]) {
        [_arrViewHit addObject:view];
        for (UIView *subView in view.subviews) {
            CGPoint subPoint = CGPointMake(point.x - subView.frame.origin.x,
                                           point.y - subView.frame.origin.y);
            [self hitTest:subView Point:subPoint];
        }
    }
}

- (void)show {
    self.hidden = NO;
}

- (void)hide {
    [_viewBound removeFromSuperview];
    self.hidden = YES;
}

@end
