//
//  SchoolModal.h
//  test15
//
//  Created by thjnh195 on 11/19/15.
//  Copyright © 2015 thjnh195. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SchoolModal : NSObject
@property (assign,nonatomic) NSInteger id;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *describle;
@property (strong,nonatomic) NSString *costring;
@property (assign,nonatomic) CGFloat local_x;
@property (assign,nonatomic) CGFloat local_y;
@end
