//
//  YYChateListVC.m
//  YYChatMovie
//
//  Created by ayong on 2017/1/3.
//  Copyright © 2017年 ayong. All rights reserved.
//

#import "YYChateListVC.h"
#import "YYChateViewVC.h"

@interface YYChateListVC ()<EaseConversationListViewControllerDelegate, EaseConversationListViewControllerDataSource>

@property (nonatomic, strong) UIView *networkStateView;

@end

@implementation YYChateListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showRefreshHeader = YES;
    self.delegate = self;
//    self.dataSource = self;
//    [self networkStateView];
//    
//    [self tableViewDidTriggerHeaderRefresh];
//    [self removeEmptyConversationsFromDB];
//
    
     YYChateViewVC *nextVC = [[YYChateViewVC alloc] initWithConversationChatter:@"sx001" conversationType:EMConversationTypeChat];
    YYChateViewVC *next2VC = [[YYChateViewVC alloc] initWithConversationChatter:@"sx002" conversationType:EMConversationTypeChat];
   
}

#pragma mark - EaseConversationListViewControllerDelegate

- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel
{
    if (conversationModel) {
        EMConversation *conversation = conversationModel.conversation;

       YYChateViewVC *chatController = [[YYChateViewVC alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
        //#endif
        chatController.title = conversationModel.title;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatController animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];
        [self.tableView reloadData];
        self.hidesBottomBarWhenPushed = NO;
    }
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
