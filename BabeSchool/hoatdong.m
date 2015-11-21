//
//  HoatDong.m
//  BabeSchool
//
//  Created by thjnh195 on 11/21/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "HoatDong.h"

@implementation HoatDong
+ (HoatDong*) getObjectFromParse:(PFObject*)Parse {
    HoatDong *cmt =[[HoatDong alloc]init];
    cmt.content = [Parse objectForKey:@"content"];
    cmt.date = [Parse objectForKey:@"date"];
    cmt.title = [Parse objectForKey:@"title"];
    cmt.imgUrl = [Parse objectForKey:@"img"];
    return cmt;
}
@end
