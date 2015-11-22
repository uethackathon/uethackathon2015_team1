//
//  HoatDongCellTableViewCell.m
//  BabeSchool
//
//  Created by thjnh195 on 11/21/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) bindData:(HoatDong*) hoatdong{
    _title.text = hoatdong.title;
    _date.text = hoatdong.date;
    _content.text = hoatdong.content;
    _img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:hoatdong.imgUrl]]];
}
@end
