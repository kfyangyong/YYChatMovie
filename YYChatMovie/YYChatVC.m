//
//  YYChatVC.m
//  YYChatMovie
//
//  Created by ayong on 2016/12/12.
//  Copyright © 2016年 ayong. All rights reserved.
//

#import "YYChatVC.h"
#import "YYChatCell.h"
#import "YYChatDetailVC.h"
@interface YYChatVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong) NSMutableArray *datasourceMuArr;
@end

@implementation YYChatVC

 static NSString *identifier = @"YYChatCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.datasourceMuArr = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YYChatCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.datasourceMuArr.count;
    return 24;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYChatCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YYChatDetailVC *vc = [[YYChatDetailVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    self.hidesBottomBarWhenPushed = YES;
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
