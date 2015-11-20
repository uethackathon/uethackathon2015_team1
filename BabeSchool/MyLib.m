//
//  MyLib.m
//  BabeSchool
//
//  Created by Truong Huu Thao on 11/21/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "MyLib.h"

@implementation MyLib
+ (BOOL) logined {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"user"];
}
@end
