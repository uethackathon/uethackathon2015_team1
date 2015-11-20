//
//  User.h
//  BabeSchool
//
//  Created by Truong Huu Thao on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, assign) NSInteger schoolId;
+ (User*) getObjectFromDict:(NSDictionary*) dict;
@end
