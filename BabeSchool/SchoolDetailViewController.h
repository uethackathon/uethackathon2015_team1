//
//  SchoolDetailViewController.h
//  BabeSchool
//
//  Created by thjnh195 on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KASlideShow.h"
@interface SchoolDetailViewController : UIViewController<KASlideShowDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnDescrible;
@property (weak, nonatomic) IBOutlet UIButton *btnCosting;
@property (assign,nonatomic) CGFloat local_x;
@property (assign,nonatomic) CGFloat local_y;
@end
