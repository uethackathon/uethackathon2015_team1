//
//  HoatDongViewController.m
//  BabeSchool
//
//  Created by thjnh195 on 11/21/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "HoatDongViewController.h"
#import <Parse/Parse.h>
#import <MBProgressHUD.h>
#import "HoatDong.h"
#import "HoatDongCellTableViewCell.h"
@interface HoatDongViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *arrayNot;
}
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;

@end

@implementation HoatDongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"Bảng tin";
    arrayNot =[[NSMutableArray alloc]init];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayNot count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 400;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HoatDongCellTableViewCell *cell = (HoatDongCellTableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"hoatDongCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HoatDongCellTableViewCell" owner:self options:nil] objectAtIndex:0];
        
        HoatDong *hoatdong = [arrayNot objectAtIndex:indexPath.row];
        [cell bindData:hoatdong];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    
//    UITableViewCell *cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:@"Cell1"];
//    //Setup array
//    
//    HoatDong *hoatdong =[arrayNot objectAtIndex:indexPath.row];
//    cell.textLabel.lineBreakMode= NSLineBreakByWordWrapping;
//    cell.textLabel.numberOfLines = 0;
//    cell.textLabel.text=hoatdong.date;
//    cell.textLabel.font=[UIFont systemFontOfSize:14.0];
//    cell.detailTextLabel.text= [NSString stringWithFormat:@"%@",hoatdong.content];
//    cell.detailTextLabel.textColor=[UIColor blueColor];
//    cell.detailTextLabel.font=[UIFont systemFontOfSize:16.0];
//    cell.detailTextLabel.lineBreakMode= NSLineBreakByWordWrapping;
//    cell.detailTextLabel.numberOfLines = 0;
//    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}
-(void)getData{
    PFQuery *query = [PFQuery queryWithClassName:@"HoatDong"];
    [query orderByDescending:@"createdAt"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        for (int index = 0; index < objects.count; index++) {
            HoatDong *hoatdong = [HoatDong getObjectFromParse:[objects objectAtIndex:index]];
            if (hoatdong) {
                [arrayNot addObject:hoatdong];
            }
        }
        [self.tableVIew reloadData];
    }];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
