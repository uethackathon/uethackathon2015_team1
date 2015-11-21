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
    school.local_x = [[dict objectForKey:@"longlatitud"] floatValue];
    school.local_y = [[dict objectForKey:@"latitude"] floatValue];
    school.arrayImages = [dict objectForKey:@"imgs"];
    return school;
}

+ (School*) getObjectFromParse:(PFObject *)schoolParse {
    School *school = [[School alloc] init];
    school.schoolId = [[schoolParse objectForKey:@"schoolId"] integerValue];
    school.name = [schoolParse objectForKey:@"name"];
    school.address = [schoolParse objectForKey:@"address"];
    school.describle = [schoolParse objectForKey:@"describle"];
    school.mobile = [schoolParse objectForKey:@"mobile"];
    school.costring = [schoolParse objectForKey:@"costring"];
    school.local_x = [[schoolParse objectForKey:@"longlatitud"] floatValue];
    school.local_y = [[schoolParse objectForKey:@"latitude"] floatValue];
    school.arrayImages = [schoolParse objectForKey:@"imgs"];
    return school;
}
@end
