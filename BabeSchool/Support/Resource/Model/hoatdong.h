//
//  HoatDong.h
//  BabeSchool
//
//  Created by thjnh195 on 11/21/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@interface HoatDong : NSObject
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *imgUrl;
@property (strong,nonatomic) NSString *content;
@property (strong,nonatomic) NSString *date;
+ (HoatDong*) getObjectFromParse:(PFObject*)Parse ;

@end
