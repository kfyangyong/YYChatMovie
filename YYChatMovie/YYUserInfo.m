//
//  YYUserInfo.m
//  YYChatMovie
//
//  Created by ayong on 2016/12/16.
//  Copyright © 2016年 ayong. All rights reserved.
//

#import "YYUserInfo.h"

@interface YYUserInfo ()
@property (nonatomic, strong) NSString *passeword;
@property (nonatomic, strong) NSString *usserName;

@end

@implementation YYUserInfo

- (NSString *)passeword{
    if (_passeword == nil) {
//        _passeword = 
    }
    return _passeword;
}

- (NSString *)usserName{
    if (_usserName == nil) {
        
    }
    return _usserName;
}

+ (instancetype)sharUserInfo{
    static YYUserInfo *userInfo;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        userInfo = [[YYUserInfo alloc] init];
    });
    return userInfo;
}

- (NSString *)getUserName{
    return self.usserName;
}
- (NSString *)getPasseWord{
    return self.passeword;
}

- (void)saveUserInfo:(NSString *)name andPasseWord:(NSString *)pwd{
    
}
@end
