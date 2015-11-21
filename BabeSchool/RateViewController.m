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
@interface RateViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *arrayComments;
}
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayComments =[[NSMutableArray alloc]init];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnVietBinhLuan:(id)sender {
    VietBLViewController *bl=[[VietBLViewController alloc]initWithNibName:@"VietBLViewController" bundle:nil];
    [self presentViewController:bl animated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayComments count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:@"Cell"];
    Comment *cmt =[arrayComments objectAtIndex:indexPath.row];
    cell.textLabel.text=cmt.content;
    cell.textLabel.font=[UIFont systemFontOfSize:18.0];
    cell.detailTextLabel.text= [NSString stringWithFormat:@"%@   %@", cmt.userName,cmt.date];
    cell.detailTextLabel.textColor=[UIColor blueColor];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:15.0];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}
-(void)getData{
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
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
