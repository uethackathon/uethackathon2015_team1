//
//  SchoolCell.h
//  BabeSchool
//
//  Created by Truong Huu Thao on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbDescription;


@end
