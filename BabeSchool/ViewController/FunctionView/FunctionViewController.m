//
//  FunctionViewController.m
//  BabeSchool
//
//  Created by thjnh195 on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "FunctionViewController.h"
#import "LiveStreamViewController.h"
#import "MenuViewController.h"
#import "HealthViewController.h"
#import "KLCPopup.h"
#import "NoticeView.h"
#import <MBProgressHUD.h>
#import <Parse/Parse.h>
#import "ListSchoolViewController.h"
#import "Utils.h"
#import "PianoViewController.h"
#import "ActivityViewController.h"
@interface FunctionViewController ()

@end

@implementation FunctionViewController {
    KLCPopup *popup;
    NoticeView *noticeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Chức Năng";
    self.navigationItem.hidesBackButton = YES;
    
    noticeView = [[[NSBundle mainBundle] loadNibNamed:@"NoticeView" owner:self options:nil] objectAtIndex:0];
    [noticeView.btnSend addTarget:self action:@selector(btnSendClick:) forControlEvents:UIControlEventTouchUpInside];
    [noticeView.btnCancel addTarget:self action:@selector(btnCancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [noticeView.layer setCornerRadius:5.0f];
    
    UIButton *btnList = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    [btnList setImage:[UIImage imageNamed:@"btn_list.png"] forState:UIControlStateNormal];
    btnList.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnList addTarget:self action:@selector(btnListClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnList];
    
    UIButton *btnLogout = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    [btnLogout setImage:[UIImage imageNamed:@"btn_logout.png"] forState:UIControlStateNormal];
    btnLogout.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btnLogout addTarget:self action:@selector(btnLogoutClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnLogout];
    
        popup = [KLCPopup popupWithContentView:noticeView showType:KLCPopupShowTypeGrowIn dismissType:KLCPopupDismissTypeGrowOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:NO dismissOnContentTouch:NO];
    // Do any additional setup after loading the view from its nib.
}

- (void) btnListClick: (UIButton*) button {
    if ([self isRootView]) {
        ListSchoolViewController *listSchoolVC = [[ListSchoolViewController alloc] initWithNibName:@"ListSchoolViewController" bundle:nil];
        [self.navigationController pushViewController:listSchoolVC animated:YES];
    }
    else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnThucDonClicked:(id)sender {
    MenuViewController *thucDonVC =[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
    [self.navigationController pushViewController:thucDonVC animated:YES];
}
- (IBAction)btnSucKhoeClicked:(id)sender {
    HealthViewController *sucKhoeVC =[[HealthViewController alloc]initWithNibName:@"HealthViewController" bundle:nil];
    [self.navigationController pushViewController:sucKhoeVC animated:YES];
}
- (IBAction)btnThongBaoClicked:(id)sender {
    [popup showAtCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3.5) inView:self.view];
}
- (IBAction)btnLiveStreamClicked:(id)sender {
    if([Utils networkConnected]){
        LiveStreamViewController *liveVC =[[LiveStreamViewController
                                            alloc]initWithNibName:@"LiveStreamViewController" bundle:nil];
        [self.navigationController pushViewController:liveVC animated:YES];
    }
    else{
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"No Internet" message:@"Vui lòng kiểm tra kết nối mạng " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void) btnSendClick: (UIButton*) button {
    if(![noticeView.txtContent.text isEqualToString:@""]){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        PFObject *notice = [PFObject objectWithClassName:@"ThongBao"];
        notice[@"thongbao"] = noticeView.txtContent.text;
        [notice saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Đã gửi đến nhà trường" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            } else {
                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Error" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
    else{
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Nhập nội dung trước khi gửi" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    [popup dismiss:YES];
    noticeView.txtContent.text = @"";
}

- (void) btnCancelClick: (UIButton*) button {
    [popup dismiss:YES];
    noticeView.txtContent.text = @"";
}

- (IBAction)btnLogoutClick:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
    if ([self isRootView]) {
        ListSchoolViewController *listSchoolVC = [[ListSchoolViewController alloc] initWithNibName:@"ListSchoolViewController" bundle:nil];
        [self.navigationController pushViewController:listSchoolVC animated:YES];
    }
    else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (BOOL) isRootView {
    UIViewController *vc = [[self.navigationController viewControllers] objectAtIndex:0];
    if([vc isEqual: self ])
    {
        return YES;
    }
    else {
        return NO;
    }
}
- (IBAction)btnGameClick:(id)sender {
    PianoViewController *pianoVC = [[PianoViewController alloc] initWithNibName:@"PianoViewController" bundle:nil];
    [self presentViewController:pianoVC animated:YES completion:nil];
}
- (IBAction)btnHoatDongClicked:(id)sender {
    ActivityViewController *hoatdongVC = [[ActivityViewController alloc] initWithNibName:@"ActivityViewController" bundle:nil];
    [self.navigationController pushViewController:hoatdongVC animated:YES ];
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
