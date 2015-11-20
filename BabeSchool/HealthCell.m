//
//  HeathCell.m
//  BabeSchool
//
//  Created by Truong Huu Thao on 11/21/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "HealthCell.h"
#import "MyLib.h"

@implementation HealthCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) bindData:(Health *)health {
    self.lbWeek.text = [NSString stringWithFormat:@"Tuần %i (%@)", health.weekId, health.date];
    self.lbHeight.text = [NSString stringWithFormat:@"Chiều cao: %.0f cm", health.height];
    self.lbWeight.text = [NSString stringWithFormat:@"Cân nặng: %.1f kg", health.weight];
    self.lbStatus.text = [MyLib checkBMI:health.height :health.weight];
}

@end
