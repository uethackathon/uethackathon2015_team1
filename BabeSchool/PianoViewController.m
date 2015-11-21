//
//  MainViewController.m
//  piano
//
//  Created by Truong Huu Thao on 11/21/15.
//  Copyright (c) 2015 Truong Huu Thao. All rights reserved.
//

#import "PianoViewController.h"
#import "SoundBankPlayer.h"

@interface PianoViewController ()
{
    SoundBankPlayer *soundBankPlayer;
    NSArray *arrMusicalNotes;
    NSInteger playing;
}
@property (weak, nonatomic) IBOutlet UIButton *btnDo;
@property (weak, nonatomic) IBOutlet UIButton *btnRe;
@property (weak, nonatomic) UIButton *currentButton;
@end

@implementation PianoViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupVC];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Setup View Controller
- (void) setupVC {
    soundBankPlayer = [[SoundBankPlayer alloc] init];
    [soundBankPlayer setSoundBank:@"Piano"];
    arrMusicalNotes = [NSArray arrayWithObjects:@"60", @"62", @"64", @"65", @"67", @"69", @"71", @"72", nil];
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDrag:)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)handleDrag:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.view];
    UIView *draggedView = [self.view hitTest:point withEvent:nil];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if ([draggedView isKindOfClass:[UIButton class]] && !self.currentButton) {
            self.currentButton = (UIButton *)draggedView;
            
            if (playing != self.currentButton.tag) {
                int numOfNote = [[arrMusicalNotes objectAtIndex:self.currentButton.tag] intValue];
                [soundBankPlayer queueNote:numOfNote gain:1.0f];
                [soundBankPlayer playQueuedNotes];
            }
            [self.currentButton sendActionsForControlEvents:UIControlEventTouchDragEnter];
        }
        
        if (self.currentButton && ![self.currentButton isEqual:draggedView]) {
            [self.currentButton sendActionsForControlEvents:UIControlEventTouchDragExit];
            self.currentButton = nil;
        }
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        self.currentButton = nil;
    }
}

#pragma mark - Setup Musical Note
- (IBAction)btnMusicalNoteclick:(id)sender {
    int numOfNote = [[arrMusicalNotes objectAtIndex:((UIButton*)sender).tag] intValue];
    playing = ((UIButton*) sender).tag;
    [soundBankPlayer queueNote:numOfNote gain:1.0f];
    [soundBankPlayer playQueuedNotes];
}
- (IBAction)btnBackClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
