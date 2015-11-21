//
//  Comment.m
//  BabeSchool
//
//  Created by thjnh195 on 11/21/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "Comment.h"

@implementation Comment
+ (Comment*) getObjectFromParse:(PFObject*)Parse {
    Comment *cmt =[[Comment alloc]init];
    cmt.userName = [Parse objectForKey:@"username"];
    cmt.content = [Parse objectForKey:@"content"];
//    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    [format setDateFormat:@"MMM dd, yyyy HH:mm"];
    cmt.date = [Parse objectForKey:@"Date"];
    return cmt;
}
@end
