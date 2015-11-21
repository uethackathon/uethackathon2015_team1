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
@interface LiveStreamViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) MPMoviePlayerController *streamPlayer;
@end

@implementation LiveStreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *streamURL = [NSURL URLWithString:@"http://a6e780.entrypoint.cloud.wowza.com/app-b91a/ngrp:ada445fe_all/playlist.m3u8"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.webView loadRequest:[NSURLRequest requestWithURL:streamURL]];
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
