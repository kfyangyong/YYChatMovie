//
//  AppDelegate.m
//  YYChatMovie
//
//  Created by ayong on 2016/12/12.
//  Copyright © 2016年 ayong. All rights reserved.
//

#import "AppDelegate.h"
#import "KeyboardManager.h"
#import "YYLogInVC.h"
#import "EMSDK.h"
@interface AppDelegate ()<EMClientDelegate>

@end

@implementation AppDelegate

static NSString *Kappkey = @"1152161212178844#yychatmovie";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.backgroundColor = [UIColor whiteColor];
    self.window = window;
    [self setRootViewController];
    [self.window makeKeyAndVisible];
    
    //弹出键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:Kappkey];
//    options.apnsCertName = @"istore_dev";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    return YES;
}

- (void)setRootViewController{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    if (isAutoLogin) {
        //登录
        
        //切换根视图
        UITabBarController *tabbar = [mainStoryboard instantiateViewControllerWithIdentifier:@"tabbar"];
        [self.window setRootViewController:tabbar];
    }else{
        YYLogInVC *LoginVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"YYLogInVC"];
        [self.window setRootViewController:LoginVC];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - EMClientDelegate
//*  SDK连接服务器的状态变化时会接收到该回调
//*  有以下几种情况, 会引起该方法的调用:
//*  1. 登录成功后, 手机无法上网时, 会调用该回调
//*  2. 登录成功后, 网络状态变化时, 会调用该回调
- (void)connectionStateDidChange:(EMConnectionState)aConnectionState{
    
}

/*!
 *  自动登录失败时的回调
 */
- (void)autoLoginDidCompleteWithError:(EMError *)aError{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YYLogInVC *LoginVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"YYLogInVC"];
    [self.window setRootViewController:LoginVC];
}

/*!
 *  当前登录账号在其它设备登录时会接收到此回调
 */
- (void)userAccountDidLoginFromOtherDevice{
    
}

/*!
 *  当前登录账号已经被从服务器端删除时会收到该回调
 */
- (void)userAccountDidRemoveFromServer{
    
}

@end
