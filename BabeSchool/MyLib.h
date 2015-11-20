//
//  MyLib.h
//  BabeSchool
//
//  Created by Truong Huu Thao on 11/21/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyLib : NSObject
+ (BOOL) logined;
+ (NSString*) checkBMI: (CGFloat) height :(CGFloat) weight;
@end
