//
//  YYRegisterVC.m
//  YYChatMovie
//
//  Created by ayong on 2016/12/12.
//  Copyright © 2016年 ayong. All rights reserved.
//

#import "YYRegisterVC.h"
#import "EMSDK.h"
@interface YYRegisterVC ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repassword;
@property (weak, nonatomic) IBOutlet UITextField *checkNum;
@property (weak, nonatomic) IBOutlet UILabel *num1;
@property (weak, nonatomic) IBOutlet UILabel *num2;

@end

@implementation YYRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger num = arc4random()%10;
    self.num1.text = [NSString stringWithFormat:@"%ld",(long)num];
    num = arc4random()%10;
    self.num2.text = [NSString stringWithFormat:@"%ld",(long)num];
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)backClick:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didFinishAdd:(UIButton *)sender {
    if (![self allIsFull]) {
        return;
    }
    
    //注册
    EMError *error = [[EMClient sharedClient] registerWithUsername:self.userName.text password:self.password.text];
    if (error==nil) {
        NSLog(@"注册成功");
        
        //登录
        EMError *error = [[EMClient sharedClient] loginWithUsername:self.userName.text password:self.password.text];
        if (!error) {
            NSLog(@"登录成功");
            //跳转聊天界面
            UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UITabBarController *tabbarVC = [main instantiateViewControllerWithIdentifier:@"tabbar"];
            [self presentViewController:tabbarVC animated:YES completion:nil];
        }
    }
}

- (BOOL)allIsFull{
    BOOL isParperRight = NO;
    
    if ([self.userName.text isEqualToString:@""]|[self.password.text isEqualToString:@""]|[self.repassword.text isEqualToString:@""]|[self.checkNum.text isEqualToString:@""]) {
        return NO;
    }
    if ([self.password.text isEqualToString:self.repassword.text]) {
        isParperRight = YES;
    }
    NSInteger numA = [self.num1.text integerValue];
    NSInteger numB = [self.num2.text integerValue];
    NSInteger numC = [self.checkNum.text integerValue];
    if (numC != numB + numA) {
        isParperRight = NO;
    }
    return isParperRight;
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
