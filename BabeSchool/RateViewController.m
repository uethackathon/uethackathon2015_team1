//
//  RateViewController.m
//  BabeSchool
//
//  Created by thjnh195 on 11/21/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "RateViewController.h"
#import "VietBLViewController.h"
#import <Parse/Parse.h>
#import <MBProgressHUD.h>
#import "Comment.h"
#import "KLCPopup.h"
#import "WriteComment.h"
#import "MyLib.h"

@interface RateViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *arrayComments;
    __weak IBOutlet UIButton *btnWriteComment;
}
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RateViewController {
    KLCPopup *popup;
    WriteComment *writeComment;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![MyLib logined]) {
        btnWriteComment.hidden = YES;
    }
    arrayComments =[[NSMutableArray alloc]init];
    _tableView.separatorColor = [UIColor clearColor];
    [self getData];
    
    writeComment = [[[NSBundle mainBundle] loadNibNamed:@"WriteComment" owner:self options:nil] objectAtIndex:0];
    [writeComment.btnSend addTarget:self action:@selector(btnSendClick:) forControlEvents:UIControlEventTouchUpInside];
    [writeComment.btnCancel addTarget:self action:@selector(btnCancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [writeComment.layer setCornerRadius:5.0f];
    
    popup = [KLCPopup popupWithContentView:writeComment];
    // Do any additional setup after loading the view from its nib.
}

- (void) btnSendClick: (UIButton*) button {
    if(![writeComment.txtContent.text isEqualToString:@""]){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        PFObject *comment = [PFObject objectWithClassName:@"Comment"];
        comment[@"content"] = writeComment.txtContent.text;
        comment[@"username"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
        comment[@"Date"] = [dateFormatter stringFromDate:[NSDate date]];
        comment[@"schoolId"] = [NSString stringWithFormat:@"%i", self.schoolId];
        [comment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [self getData];
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
    writeComment.txtContent.text = @"";
}

- (void) btnCancelClick: (UIButton*) button {
    [popup dismiss:YES];
    writeComment.txtContent.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnVietBinhLuan:(id)sender {
    [popup show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayComments count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Comment *cmt =[arrayComments objectAtIndex:indexPath.row];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:18]};
    // NSString class method: boundingRectWithSize:options:attributes:context is
    // available only on ios7.0 sdk.
    CGRect rect = [cmt.content boundingRectWithSize:CGSizeMake(320, CGFLOAT_MAX)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    
    float heightToAdd = MIN(rect.size.height, 100.0f); //Some fix height is returned if height is small or change it to MAX(textSize.height, 150.0f); // whatever best fits for you
    
    return heightToAdd+30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:@"Cell"];
    //Setup array
    
    Comment *cmt =[arrayComments objectAtIndex:indexPath.row];
    cell.textLabel.lineBreakMode= NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text=cmt.content;
    cell.textLabel.font=[UIFont systemFontOfSize:18.0];
    cell.detailTextLabel.text= [NSString stringWithFormat:@"%@   %@", cmt.userName,cmt.date];
    cell.detailTextLabel.textColor=[UIColor blueColor];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:15.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}
-(void)getData{
    //Get Data from server
    [arrayComments removeAllObjects];
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    [query orderByDescending:@"createdAt"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [query whereKey:@"schoolId" equalTo:[NSString stringWithFormat:@"%d",self.schoolId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                Comment *cmt = [Comment getObjectFromParse:object];
                [arrayComments addObject:cmt];
            }
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
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
