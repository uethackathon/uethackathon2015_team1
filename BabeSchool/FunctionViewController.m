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
#import "KLCPopup.h"
#import "NoticeView.h"
#import <MBProgressHUD.h>
#import <Parse/Parse.h>
#import "ListSchoolViewController.h"

@interface FunctionViewController ()

@end

@implementation FunctionViewController {
    KLCPopup *popup;
    NoticeView *noticeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Các chức năng";
    self.navigationItem.hidesBackButton = YES;
    
    noticeView = [[[NSBundle mainBundle] loadNibNamed:@"NoticeView" owner:self options:nil] objectAtIndex:0];
    [noticeView.btnSend addTarget:self action:@selector(btnSendClick:) forControlEvents:UIControlEventTouchUpInside];
    [noticeView.btnCancel addTarget:self action:@selector(btnCancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [noticeView.layer setCornerRadius:5.0f];
    
    UIButton *btnList = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
    [btnList setImage:[UIImage imageNamed:@"btn_list.png"] forState:UIControlStateNormal];
    btnList.titleLabel.font = [UIFont systemFontOfSize:16];
    btnList.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnList addTarget:self action:@selector(btnListClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnList];
    
    popup = [KLCPopup popupWithContentView:noticeView];
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
    ThucDonViewController *thucDonVC =[[ThucDonViewController alloc]initWithNibName:@"ThucDonViewController" bundle:nil];
    [self.navigationController pushViewController:thucDonVC animated:YES];
}
- (IBAction)btnSucKhoeClicked:(id)sender {
    SucKhoeViewController *sucKhoeVC =[[SucKhoeViewController alloc]initWithNibName:@"SucKhoeViewController" bundle:nil];
    [self.navigationController pushViewController:sucKhoeVC animated:YES];
}
- (IBAction)btnThongBaoClicked:(id)sender {
    [popup show];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
