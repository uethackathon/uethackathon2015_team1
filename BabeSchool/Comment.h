//
//  Comment.h
//  BabeSchool
//
//  Created by thjnh195 on 11/21/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@interface Comment : NSObject
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *content;
@property (strong,nonatomic) NSString *date;
+ (Comment*) getObjectFromParse:(PFObject*)Parse ;

@end
