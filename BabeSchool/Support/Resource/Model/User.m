//
//  User.m
//  BabeSchool
//
//  Created by Truong Huu Thao on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "User.h"

@implementation User
+ (User*) getObjectFromDict:(NSDictionary *)dict {
    User *user = [[User alloc] init];
    user.userId = [[dict objectForKey:@"id"] integerValue];
    user.username = [dict objectForKey:@"username"];
    user.password = [dict objectForKey:@"password"];
    user.schoolId = [[dict objectForKey:@"schoolId"] integerValue];
    return user;
}
@end
