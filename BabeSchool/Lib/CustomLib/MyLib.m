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

+ (NSString *)normalizeVietnameseString:(NSString *)str {
    NSMutableString *originStr = [NSMutableString stringWithString:str];
    CFStringNormalize((CFMutableStringRef)originStr, kCFStringNormalizationFormD);
    
    CFStringFold((CFMutableStringRef)originStr, kCFCompareDiacriticInsensitive, NULL);
    
    NSString *finalString1 = [originStr stringByReplacingOccurrencesOfString:@"đ"withString:@"d"];
    
    NSString *finalString2 = [finalString1 stringByReplacingOccurrencesOfString:@"Đ"withString:@"D"];
    return finalString2;
}

+ (BOOL) isNumber:(NSString *)inputNumber {
    if ([inputNumber isEqualToString:@"0"]) {
        return NO;
    }
    NSCharacterSet *numberic = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890."] invertedSet];
    return [inputNumber rangeOfCharacterFromSet:numberic].location == NSNotFound;
}
@end
