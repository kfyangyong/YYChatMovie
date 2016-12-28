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
#import "YYKeyChain.h"
@interface AppDelegate ()<EMClientDelegate>

@end

@implementation AppDelegate

static NSString *Kappkey = @"1152161212178844#yychatmovie";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
    
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.backgroundColor = [UIColor whiteColor];
    self.window = window;
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [path stringByAppendingString:@"/info.plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    NSString *str = arr.firstObject;
    NSLog(@"是否自动登录%@",str);
    if ([str isEqualToString:@"自动登录"]) {
       
        [self autoLogIn];
    }else{
        [self setRootViewController:NO];
    }
    
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

- (void)autoLogIn{
    //登录方式2 回调
    NSString * nameAndPwd = [YYKeyChain yyKeyChainLoad];
    if (nameAndPwd) {
        NSLog(@"账号信息 %@",nameAndPwd);
        NSArray *arr = [nameAndPwd componentsSeparatedByString:@","];
        NSString *name = arr[0];
        NSString *pwd = arr[1];
        EMError *error;
        //登录方式1 这里会出现登录失败导致不能自动登录
        error = [[EMClient sharedClient] loginWithUsername:name password:pwd];
        if (error) {
            NSLog(@"登录失败%@",error);
            [self setRootViewController:NO];;
        }else{
            [self setRootViewController:YES];
        }
       
    }else{
        [self setRootViewController:NO];
    }
}

- (void)setRootViewController:(BOOL)isauto{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (isauto) {
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
