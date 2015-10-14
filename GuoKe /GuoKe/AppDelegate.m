//
//  AppDelegate.m
//  GuoKe
//
//  Created by mac on 15/9/24.
//  Copyright (c) 2015年 dzk. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "LeftViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];


    //左 中 控制器
    HomeViewController *tlVc = [[HomeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tlVc];
    
    LeftViewController *leftVc = [[LeftViewController alloc] init];
    
    //
    MMDrawerController *mmdraw = [[MMDrawerController alloc] initWithCenterViewController:nav leftDrawerViewController:leftVc];
    //设置左边宽度
    [mmdraw setMaximumLeftDrawerWidth:250];
    
    //设置手势有效区域
    [mmdraw setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [mmdraw setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //设置动画类型
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeSlide];
    
    //设置动画效果
    [mmdraw setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
            block(drawerController,drawerSide,percentVisible);
        }
    }];
    
    self.window.rootViewController = mmdraw;
    
    //创建微博对象
    self.sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
    
    //读取本地持久化数据(令牌，用户id)
    [self readAuthData];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
//
//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//删除数据
- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}
//保存数据
- (void)storeAuthData
{
    SinaWeibo *sinaweibo = self.sinaweibo;
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//读取数据
-(void)readAuthData{
    SinaWeibo *sinaweibo = self.sinaweibo;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
}
#pragma mark - 新浪微博登陆代理
//登陆成功
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    NSLog(@"登陆成功");
    NSLog(@"%@,%@,%@",self.sinaweibo.accessToken,self.sinaweibo.userID,self.sinaweibo.expirationDate);
    
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"登录成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alterView show];
    
    [self storeAuthData];
}
//等出成功
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo{
    NSLog(@"登出成功");
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"登出成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alterView show];
    
    [self removeAuthData];
}
//登陆取消
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo{
    
}
//登陆失败
- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error{
    
}
//令牌过期
- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error{
    
}
//SSO 授权回调处理
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self.sinaweibo handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self.sinaweibo handleOpenURL:url];
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self.sinaweibo applicationDidBecomeActive];
}

@end
