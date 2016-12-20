//
//  YYKeyChain.h
//  YYChatMovie
//
//  Created by ayong on 2016/12/20.
//  Copyright © 2016年 ayong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>


@interface YYKeyChain : NSObject

+ (void)yyKeyChainSave:(NSString *)service;
+ (void)yyKeyChainDelegate:(NSString *)service;
+ (NSString *)yyKeyChainLoad;

@end
