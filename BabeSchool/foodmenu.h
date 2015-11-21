//
//  foodmenu.h
//  BabeSchool
//
//  Created by thjnh195 on 11/21/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface foodmenu : NSObject
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSArray *arrayFoods;
+ (foodmenu*) getObjectFromParse:(PFObject*)Parse ;


@end
