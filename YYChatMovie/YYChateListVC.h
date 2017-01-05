//
//  YYChateListVC.h
//  YYChatMovie
//
//  Created by ayong on 2017/1/3.
//  Copyright © 2017年 ayong. All rights reserved.
//

#import "EaseConversationListViewController.h"

@interface YYChateListVC : EaseConversationListViewController

@property (strong, nonatomic) NSMutableArray *conversationsArray;

- (void)refresh;
- (void)refreshDataSource;

- (void)isConnect:(BOOL)isConnect;
- (void)networkChanged:(EMConnectionState)connectionState;

@end
