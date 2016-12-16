//
//  YYUserInfo.h
//  YYChatMovie
//
//  Created by ayong on 2016/12/16.
//  Copyright © 2016年 ayong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYUserInfo : NSObject

+ (instancetype)sharUserInfo;

- (NSString *)getUserName;
- (NSString *)getPasseWord;
- (void)saveUserInfo:(NSString *)name andPasseWord:(NSString *)pwd;

@end
