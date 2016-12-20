//
//  YYLogInVC.m
//  YYChatMovie
//
//  Created by ayong on 2016/12/12.
//  Copyright © 2016年 ayong. All rights reserved.
//

#import "YYLogInVC.h"
#import "YYRegisterVC.h"
#import "EMSDK.h"
#import "YYKeyChain.h"

@interface YYLogInVC ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@property (assign,nonatomic) BOOL isAuto;
@property (assign,nonatomic) BOOL isRememberPwd;

@end

@implementation YYLogInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   NSString * nameAndPwd = [YYKeyChain yyKeyChainLoad];
    if (![nameAndPwd isEqualToString:@""]) {
        NSLog(@"账号信息 %@",nameAndPwd);
        NSArray *arr = [nameAndPwd componentsSeparatedByString:@","];
        self.accountTF.text = arr[0];
        self.pwdTF.text = arr[1];
    }
}
- (BOOL)allEditEnd{
    if ([self.accountTF.text isEqualToString:@""]) {
        return NO;
    }
    if ( [self.pwdTF.text isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

#pragma mark - 点击事件
- (IBAction)LogInClick:(UIButton *)sender {
    
    if (![self allEditEnd]) {
        return;
    }
    //登录
    [EMClient sharedClient].options.isAutoLogin = self.isAuto;
   
    EMError *error;
    //登录方式1
    error = [[EMClient sharedClient] loginWithUsername:self.accountTF.text password:self.pwdTF.text];
    if (error) {
        NSLog(@"登录失败");
        return;
    }
    UITabBarController *tabbarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
    [self presentViewController:tabbarVC animated:YES completion:nil];
    
    //登录方式2 回调
//    [[EMClient sharedClient] loginWithUsername:self.accountTF.text password:self.pwdTF.text completion:^(NSString *aUsername, EMError *aError) {
//        if (aError) {
//            NSLog(@"登录失败");
//            return;
//        }
//        UITabBarController *tabbarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
//        [self presentViewController:tabbarVC animated:YES completion:nil];
//    }];
    
    NSString *userName = self.accountTF.text;
    NSString *passWord = self.pwdTF.text;
    NSString *namePwd = [NSString stringWithFormat:@"%@,%@",userName,passWord];
    //记住密码
    if (self.isRememberPwd) {
        [YYKeyChain yyKeyChainSave:namePwd];
    }else{
        [YYKeyChain yyKeyChainDelegate:namePwd];
    }
    if (self.isAuto) {
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *filePath = [path stringByAppendingString:@"/info.plist"];
        NSArray *arr = @[@"自动登录"];
        [arr writeToFile:filePath atomically:YES];
    }
}

- (IBAction)addNewUser:(UIButton *)sender {
    YYRegisterVC *registerVC = [[YYRegisterVC alloc] init];
    [self presentViewController:registerVC animated:YES completion:nil];
}

- (IBAction)forgetPassword:(UIButton *)sender {
    
}

- (IBAction)autoLogin:(UIButton *)sender {
    self.isAuto = self.isAuto == YES ? NO:YES;
    if (self.isAuto) {
        [sender setImage:[UIImage imageNamed:@"selecticon"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"unselecticon"] forState:UIControlStateNormal];
    }
}

- (IBAction)rememberPwd:(UIButton *)sender {
    self.isRememberPwd = self.isRememberPwd == YES ? NO:YES;
    if (self.isRememberPwd) {
        [sender setImage:[UIImage imageNamed:@"selecticon"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"unselecticon"] forState:UIControlStateNormal];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
