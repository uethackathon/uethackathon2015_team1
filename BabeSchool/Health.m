//
//  Health.m
//  BabeSchool
//
//  Created by Truong Huu Thao on 11/21/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "Health.h"

@implementation Health
+ (Health*) getObjectFromDict:(NSDictionary *)dict {
    Health *health = [[Health alloc] init];
    health.healthId = [[dict objectForKey:@"id"] integerValue];
    health.height = [[dict objectForKey:@"height"] floatValue];
    health.weight = [[dict objectForKey:@"weight"] floatValue];
    health.date = [dict objectForKey:@"date"];
    return health;
}

+ (Health*) getObjectFromParse:(PFObject *)healthParse {
    Health *health = [[Health alloc] init];
    health.healthId = [[healthParse objectForKey:@"healthId"] integerValue];
    health.height = [[healthParse objectForKey:@"height"] floatValue];
    health.weight = [[healthParse objectForKey:@"weight"] floatValue];
    health.date = [healthParse objectForKey:@"date"];
    return health;
}
@end
