//
//  AppDelegate.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/5.
//

#import "AppDelegate.h"
#import "FGMDHomeListVC.h"
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:UIColorWhite];
    
    FGMDHomeListVC *homeVC = [[FGMDHomeListVC alloc]init];
    QMUINavigationController *naviVC = [[QMUINavigationController alloc]initWithRootViewController:homeVC];
    [self.window setRootViewController:naviVC];
    [self.window makeKeyAndVisible];
    
// 初始化配置
    SAConfigOptions *options = [[SAConfigOptions alloc] initWithServerURL:@"http://10.10.1.78:8106/sa/sa?project=EbizDemo" launchOptions:launchOptions];
    // 开启全埋点
    options.autoTrackEventType = SensorsAnalyticsEventTypeAppStart |
                                 SensorsAnalyticsEventTypeAppEnd |
                                 SensorsAnalyticsEventTypeAppClick |
                                 SensorsAnalyticsEventTypeAppViewScreen;
#ifdef DEBUG
    // 开启 Log
    options.enableLog = YES;
#endif

    /**
     * 其他配置，如开启可视化全埋点
     */
    options.enableVisualizedAutoTrack = YES;
    // 初始化 SDK
    [SensorsAnalyticsSDK startWithConfigOptions:options];

    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([[SensorsAnalyticsSDK sharedInstance] handleSchemeUrl:url]) {
        return YES;
    }
    return NO;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
