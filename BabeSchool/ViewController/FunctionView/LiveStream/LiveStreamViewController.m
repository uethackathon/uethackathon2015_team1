//
//  LiveStreamViewController.m
//  BabeSchool
//
//  Created by thjnh195 on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "LiveStreamViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MBProgressHUD.h>
#import "Utils.h"
#import <Parse/Parse.h>
@interface LiveStreamViewController (){
    NSURL *streamURL;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) MPMoviePlayerController *streamPlayer;
@end

@implementation LiveStreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"Trực tiếp lớp học";
    PFQuery *query = [PFQuery queryWithClassName:@"StreamData"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if(!error){
            NSLog(@"Successfully retrieved %lu scores.", objects.count);
            @try{

                if([[[objects objectAtIndex:0] valueForKey:@"status"] isEqualToString:@"0"]){
                    [self fallToStream];
                }
                else{
                    streamURL = [NSURL URLWithString:[[objects objectAtIndex:0] valueForKey:@"url"]];
                    [self.webView loadRequest:[NSURLRequest requestWithURL:streamURL]];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                }
                
            }
            @catch(NSException *e){
                [self fallToStream];
            }
        }
        else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self fallToStream];
            
        }
    }];

        
    

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)fallToStream{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Opps" message:@"Hiện camera chưa sẵn sàng, quay lại vào lúc khác" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [self.navigationController popViewControllerAnimated:YES];
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
