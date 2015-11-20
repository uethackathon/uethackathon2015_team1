//
//  foodmenu.m
//  BabeSchool
//
//  Created by thjnh195 on 11/21/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "foodmenu.h"

@implementation foodmenu
+ (foodmenu*) getObjectFromJSON:(NSDictionary *)dict {
    foodmenu *food =[[foodmenu alloc]init];
    food.name = [dict objectForKey:@"name"];
        food.arrayFoods = [dict objectForKey:@"foods"];
    return food;
}
@end
