//
//  SchoolDetailViewController.m
//  BabeSchool
//
//  Created by thjnh195 on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "SchoolDetailViewController.h"
#import "KASlideShow.h"
#import "LoginViewController.h"
#import "FunctionViewController.h"
#import "CommentViewController.h"
@import GoogleMaps;
@interface SchoolDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewSlideImage;
@property (weak, nonatomic) IBOutlet UIView *viewDetaild;
@property (weak, nonatomic) IBOutlet UITextView *textDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnDescribe;

@property (weak, nonatomic) IBOutlet UIButton *btnStatistics;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;
@property (weak, nonatomic) IBOutlet UIButton *btnMap;

@end

@implementation SchoolDetailViewController {
    GMSMapView *mapView_;
    KASlideShow *_slideshow;
    BOOL addedGoogleMap;
    BOOL addedRate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Chi tiết";
    [self InitSomeView]; // create some parameter
    [self btnDescribleClicked:nil]; //default is mo ta clicked
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [_slideshow stop];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnDescribleClicked:(id)sender {
    [self checkBeforeCall];
    [self setAllUnselected];
    _btnDescribe.selected = YES;
    self.textDetail.text=self.modal.describle;
    self.textDetail.font = [UIFont systemFontOfSize:17];
}
- (IBAction)btnCostingClicked:(id)sender {
    NSString *content = [self.modal.costring stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    [self checkBeforeCall];
    [self setAllUnselected];
    _btnStatistics.selected = YES;
    self.textDetail.text=content;
    self.textDetail.font = [UIFont systemFontOfSize:17];
}
- (IBAction)btnRateClicked:(id)sender {
    self.textDetail.text=nil;
    [self checkBeforeCall];
    [self setAllUnselected];
    _btnComment.selected = YES;
    if (!addedRate) {
        CommentViewController *V2 = [[CommentViewController alloc]initWithNibName:@"CommentViewController" bundle:nil];//assuming V2 is name of your nib as well
        // Call Rate screen
        V2.schoolId=self.modal.schoolId;
        [self addChildViewController:V2];
        [V2 didMoveToParentViewController:self];
        V2.view.frame =self.viewDetaild.bounds;
        [self.viewDetaild addSubview:V2.view];
        addedRate=YES;
    }
    

    
}
- (IBAction)btnMapClicked:(id)sender {
    [self setAllUnselected];
    _btnMap.selected = YES;
    if(!addedGoogleMap){
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.modal.local_x
                                                                longitude:self.modal.local_y
                                                                     zoom:15];
        mapView_ = [GMSMapView mapWithFrame:self.viewDetaild.frame camera:camera];
        mapView_.myLocationEnabled = YES;
        [self.view addSubview: mapView_];
        
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        NSLog(@"%.7f %.7f ",self.modal.local_x, self.modal.local_y);
        marker.position = CLLocationCoordinate2DMake(self.modal.local_x, self.modal.local_y);
        marker.title = self.modal.address;
        marker.map = mapView_;    // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        addedGoogleMap=YES;
    }
    
    
}
-(void)InitSomeView{
    
    
    
    addedGoogleMap=NO;
    addedRate=NO;
    [self.textDetail setHidden:YES];
    
    
    _slideshow = [[KASlideShow alloc] init];
    _slideshow.frame=self.viewSlideImage.bounds;
    [_slideshow setDelay:1.5]; // Delay between transitions
    [_slideshow setTransitionDuration:1.5]; // Transition duration
    [_slideshow setTransitionType:KASlideShowTransitionFade]; // Choose a transition type (fade or slide)
    [_slideshow setImagesContentMode:UIViewContentModeScaleAspectFill]; // Choose a content mode for images to display
    
    [_slideshow addImagesFromResources:self.modal.arrayImages]; // Add images from resources
    [_slideshow addGesture:KASlideShowGestureTap]; // Gesture to go previous/next directly on the image
    [self.viewSlideImage addSubview: _slideshow];
    [_slideshow start];
    _slideshow.delegate = self;

    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.viewSlideImage addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.viewSlideImage addGestureRecognizer:swiperight];
}

- (void) setAllUnselected {
    _btnDescribe.selected = NO;
    _btnStatistics.selected = NO;
    _btnComment.selected = NO;
    _btnMap.selected = NO;
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
-(void)checkBeforeCall{
    if(addedGoogleMap){
        [mapView_ removeFromSuperview];
        addedGoogleMap=NO;
    }
    if(addedRate){
        for (UIViewController *subVC in self.childViewControllers){
            [subVC willMoveToParentViewController:nil];
            [subVC.view removeFromSuperview];
            [subVC removeFromParentViewController];
        }
        addedRate=NO;
    }
    [self.textDetail setHidden:NO];
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
