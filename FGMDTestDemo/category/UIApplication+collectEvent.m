//
//  UIApplication+collectEvent.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/11.
//

#import "UIApplication+collectEvent.h"

@implementation UIApplication (collectEvent)
+ (void)load {
    [[self class] fg_swizzlingMethod:@selector(sendAction:to:from:forEvent:) toMethod:@selector(fgmd_sendAction:to:from:forEvent:)];
}

- (BOOL)fgmd_sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event {
    UIView *view = (UIView *)sender;
    NSString *identifier = [FGMDAutoTrackUtils getViewIdentifierWithObject:view];
    
    if (![FGMDConfig defaultConfig].circling) {
        //查找配置表
        FGMDCircleConfigModel *configModel = [[FGMDConfig defaultConfig] searchForConfigWithIdentifier:identifier];
        if (configModel) {
            //按配置项埋点
            FGMDInfoModel *infoModel = [FGMDInfoModel new];
            infoModel.eventId = @"Click";
            infoModel.logType = configModel.logType;
            infoModel.subLogType = configModel.subLogType;
            
            NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            infoModel.time = [formatter stringFromDate:[NSDate date]];
            
            [[FGMDConfig defaultConfig] insertMDInfoModel:infoModel];
        }
    }
    return [self fgmd_sendAction:action to:target from:sender forEvent:event];
}
@end
