//
//  Health.h
//  BabeSchool
//
//  Created by Truong Huu Thao on 11/21/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Health : NSObject
@property (nonatomic, assign) NSInteger healthId;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat weight;
@property (nonatomic, strong) NSString *date;

+ (Health*) getObjectFromDict: (NSDictionary*)dict;
+ (Health*) getObjectFromParse: (PFObject*) healthParse;
@end
