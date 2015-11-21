//
//  ThongBaoViewController.m
//  BabeSchool
//
//  Created by thjnh195 on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "ThongBaoViewController.h"
#import <MBProgressHUD.h>

@interface ThongBaoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textEdt;

@end

@implementation ThongBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dismissKeyboard {
    [_textEdt resignFirstResponder];
}
- (IBAction)btnSendClicked:(id)sender {
    
    if(![self.textEdt.text isEqualToString:@""]){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        PFObject *testObject = [PFObject objectWithClassName:@"ThongBao"];
        testObject[@"thongbao"] = self.textEdt.text;
        [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Error" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }
    else{
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Nhập nội dung trước khi gửi" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
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
