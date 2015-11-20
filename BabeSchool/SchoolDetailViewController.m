//
//  SchoolDetailViewController.m
//  BabeSchool
//
//  Created by thjnh195 on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "SchoolDetailViewController.h"
#import "KASlideShow.h"
#import "RateView.h"
@import GoogleMaps;
@interface SchoolDetailViewController ()<RateViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewSlideImage;
@property (weak, nonatomic) IBOutlet UIView *viewDetaild;
@property (weak, nonatomic) IBOutlet RateView *rateView;

@end

@implementation SchoolDetailViewController {
    GMSMapView *mapView_;
    KASlideShow *_slideshow;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // coordinate -33.86,151.20 at zoom level 6.

    //    // Do any additional setup after loading the view from its nib.
    
    [self InitSomeView];
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnDescribleClicked:(id)sender {
}
- (IBAction)btnCostingClicked:(id)sender {
}
- (IBAction)btnRateClicked:(id)sender {
    self.rateView.notSelectedImage = [UIImage imageNamed:@"kermit_empty.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"kermit_half.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"kermit_full.png"];
    self.rateView.rating = 0;
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    self.rateView.delegate = self;
    
}
- (IBAction)btnMapClicked:(id)sender {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:21.014818
                                                            longitude:105.849237
                                                                 zoom:15];
    mapView_ = [GMSMapView mapWithFrame:self.viewDetaild.frame camera:camera];
    mapView_.myLocationEnabled = YES;
    [self.view addSubview: mapView_];
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(21.014818, 105.849237);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
}
- (IBAction)btnLoginClicked:(id)sender {
}
-(void)InitSomeView{
    [self.rateView setHidden:YES];
    self.local_x=33.3;
    self.local_x=100;
    _slideshow = [[KASlideShow alloc] initWithFrame:CGRectMake(0,0,320,250)];
    [_slideshow setDelay:3]; // Delay between transitions
    [_slideshow setTransitionDuration:1]; // Transition duration
    [_slideshow setTransitionType:KASlideShowTransitionFade]; // Choose a transition type (fade or slide)
    [_slideshow setImagesContentMode:UIViewContentModeScaleAspectFill]; // Choose a content mode for images to display
    [_slideshow addImagesFromResources:@[@"img1_1.png",@"img1_2.png",@"img1_3.png"]]; // Add images from resources
    [_slideshow addGesture:KASlideShowGestureTap]; // Gesture to go previous/next directly on the image
    [self.viewSlideImage addSubview: _slideshow];
    _slideshow.delegate = self;

    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.viewSlideImage addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.viewSlideImage addGestureRecognizer:swiperight];
}

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating {
    //    self.statusLabel.text = [NSString stringWithFormat:@"Rating: %f", rating];
}
-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [_slideshow previous];
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //Do what you want here
    [_slideshow next];
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
