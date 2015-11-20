//
//  SchoolModal.m
//  test15
//
//  Created by thjnh195 on 11/19/15.
//  Copyright © 2015 thjnh195. All rights reserved.
//

#import "School.h"

@implementation School

+ (School*) getObjectFromJSON:(NSDictionary *)dict {
    School *school = [[School alloc] init];
    school.schoolId = [[dict objectForKey:@"id"] integerValue];
    school.name = [dict objectForKey:@"name"];
    school.address = [dict objectForKey:@"address"];
    school.describle = [dict objectForKey:@"describle"];
    school.mobile = [dict objectForKey:@"mobile"];
    school.costring = [dict objectForKey:@"costring"];
    school.local_x = [[dict objectForKey:@"latitude"] integerValue];
    school.local_y = [[dict objectForKey:@"longlatitud"] integerValue];
    school.arrayImages = [dict objectForKey:@"imgs"];
    return school;
}
@end
