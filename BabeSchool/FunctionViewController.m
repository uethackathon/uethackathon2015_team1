//
//  FunctionViewController.m
//  BabeSchool
//
//  Created by thjnh195 on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "FunctionViewController.h"
#import "LiveStreamViewController.h"
#import "ThucDonViewController.h"
#import "SucKhoeViewController.h"
#import "ThongBaoViewController.h"
@interface FunctionViewController ()

@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"Chức năng";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnThucDonClicked:(id)sender {
    ThucDonViewController *thucDonVC =[[ThucDonViewController alloc]initWithNibName:@"ThucDonViewController" bundle:nil];
    [self.navigationController pushViewController:thucDonVC animated:YES];
}
- (IBAction)btnSucKhoeClicked:(id)sender {
    SucKhoeViewController *sucKhoeVC =[[SucKhoeViewController alloc]initWithNibName:@"SucKhoeViewController" bundle:nil];
    [self.navigationController pushViewController:sucKhoeVC animated:YES];
}
- (IBAction)btnThongBaoClicked:(id)sender {
    ThongBaoViewController *thongBaoVC =[[ThongBaoViewController alloc]initWithNibName:@"ThongBaoViewController" bundle:nil];
    [self.navigationController pushViewController:thongBaoVC animated:YES];
}
- (IBAction)btnLiveStreamClicked:(id)sender {
    LiveStreamViewController *liveVC =[[LiveStreamViewController alloc]initWithNibName:@"LiveStreamViewController" bundle:nil];
    [self.navigationController pushViewController:liveVC animated:YES];
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
