//
//  SchoolCell.m
//  BabeSchool
//
//  Created by Truong Huu Thao on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "SchoolCell.h"

@implementation SchoolCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) bindData:(School *)school {
    _lbName.text = school.name;
    _lbAddress.text = school.address;
    _imgAvatar.image = [UIImage imageNamed:[school.arrayImages objectAtIndex:0]];
}
@end
