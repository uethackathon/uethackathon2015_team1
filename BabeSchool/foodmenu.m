//
//  foodmenu.m
//  BabeSchool
//
//  Created by thjnh195 on 11/21/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "foodmenu.h"

@implementation foodmenu
+ (foodmenu*) getObjectFromParse:(PFObject*)Parse {
    foodmenu *food =[[foodmenu alloc]init];
    food.name = [Parse objectForKey:@"name"];
    food.arrayFoods = [Parse objectForKey:@"foods"];
    return food;
}
@end
