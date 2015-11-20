//
//  LoginViewController.m
//  BabeSchool
//
//  Created by Truong Huu Thao on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import "FunctionViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation LoginViewController {
    NSMutableArray *arrayUser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
    [self bindData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup View Controller
- (void) setupViewController {
    _txtUsername.delegate = self;
    _txtPassword.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [_txtUsername resignFirstResponder];
    [_txtPassword resignFirstResponder];
    return YES;
}

-(void) dismissKeyboard {
    [_txtUsername resignFirstResponder];
    [_txtPassword resignFirstResponder];
}

- (void) bindData { //Get exist user
    arrayUser = [[NSMutableArray alloc] init];
    NSURL *jsonFilePath = [[NSBundle mainBundle] URLForResource:@"users" withExtension:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonFilePath];
    NSDictionary *dictUser = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = [dictUser objectForKey:@"data"];
    
    for (int index = 0; index < array.count; index++) {
        User *user = [User getObjectFromDict:[array objectAtIndex:index]];
        if (user) {
            [arrayUser addObject:user];
        }
    }
}

#pragma mark - Setup Button Action
- (IBAction)btnLoginClick:(id)sender {
    if ([self checkValid]) {
        FunctionViewController *functionVC = [[FunctionViewController alloc] initWithNibName:@"FunctionViewController" bundle:nil];
        [self.navigationController pushViewController:functionVC animated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Tài khoản hoặc mật khẩu không đúng" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - Function 
- (BOOL) checkValid {
    BOOL result = NO;
    for (int index = 0; index < arrayUser.count; index++) {
        User *user = [arrayUser objectAtIndex:index];
        if ([_txtUsername.text isEqualToString:user.username] && [_txtPassword.text isEqualToString:user.password]) {
            result = YES;
        }
    }
    return result;
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
