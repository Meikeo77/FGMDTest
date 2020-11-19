//
//  UIControl+collectEvent.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/6.
//

#import "UIControl+collectEvent.h"
#import "FGMDCircleParameterView.h"
@implementation UIControl (collectEvent)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [[self class] fg_swizzlingMethod:@selector(sendAction:to:forEvent:) toMethod:@selector(fgmd_sendAction:to:forEvent:)];
        
    });
}

- (void)fgmd_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    ///获取viewpath
    
    // 搜索配置项
    FGMDCircleConfigModel *configModel = [[FGMDConfig defaultConfig] searchForConfig:@""];
    if (configModel) {
        //按配置项埋点
        FGMDInfoModel *infoModel = [FGMDInfoModel new];
        infoModel.eventId = configModel.eventId;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        infoModel.time = [formatter stringFromDate:[NSDate date]];
        
        if (configModel.additionalKey.length > 0) {
            if ([configModel.additionalKey isEqualToString:@"title"]) {
                infoModel.content = self.elementContent;
            }
        }
        
        //插入埋点
        [[FGMDConfig defaultConfig] insertMDInfoModel:infoModel];
    }
    
    [self fgmd_sendAction:action to:target forEvent:event];
    
}

@end
