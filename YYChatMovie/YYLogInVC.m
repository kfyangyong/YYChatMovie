//
//  YYLogInVC.m
//  YYChatMovie
//
//  Created by ayong on 2016/12/12.
//  Copyright © 2016年 ayong. All rights reserved.
//

#import "YYLogInVC.h"
#import "YYRegisterVC.h"

@interface YYLogInVC ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@property (assign,nonatomic) BOOL isAuto;
@property (assign,nonatomic) BOOL isRememberPwd;

@end

@implementation YYLogInVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 点击事件
- (IBAction)LogInClick:(UIButton *)sender {
    
    
    
    UITabBarController *tabbarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
    [self presentViewController:tabbarVC animated:YES completion:nil];
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
