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

+ (NSString*) checkBMI:(CGFloat)height :(CGFloat)weight {
    CGFloat bmi = weight / ((height/100) * (height/100));
    NSLog(@"%f", bmi);
    if (bmi < 13.5) {
        return @"Thiếu cân";
    }
    if (13.5 <= bmi && bmi < 17.2) {
        return @"Sức khỏe tốt";
    }
    if (17.2 <= bmi && bmi < 19.0) {
        return @"Nguy cơ béo phì";
    }
    return @"Béo phì";
}
@end
