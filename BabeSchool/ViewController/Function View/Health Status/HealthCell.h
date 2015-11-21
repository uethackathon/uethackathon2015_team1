//
//  HeathCell.h
//  BabeSchool
//
//  Created by Truong Huu Thao on 11/21/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Health.h"

@interface HealthCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbWeek;
@property (weak, nonatomic) IBOutlet UILabel *lbHeight;
@property (weak, nonatomic) IBOutlet UILabel *lbWeight;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;

- (void) bindData: (Health*) health;
@end
