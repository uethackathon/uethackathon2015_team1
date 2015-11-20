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
    health.weekId = [[dict objectForKey:@"id"] integerValue];
    health.height = [[dict objectForKey:@"height"] floatValue];
    health.weight = [[dict objectForKey:@"weight"] floatValue];
    health.date = [dict objectForKey:@"date"];
    return health;
}
@end
