#import "HomeViewController.h"
#import "BackgroundUtil.h"
#import "AppDelegate.h"

@interface HomeViewController ()

@end

@implementation HomeViewController {

    __weak IBOutlet UILabel *timeLabel;
    __weak IBOutlet UIImageView *backgroundImageView;
    __weak IBOutlet UIView *slidingMenuView;
    __weak IBOutlet UIView *menuContainerView;
    __weak IBOutlet NSLayoutConstraint *slidingMenuLeadingConstraint;

    BOOL menuHidden;
}

#pragma mark - Utility

- (void)viewDidLoad {
    [super viewDidLoad];

    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).backgroundImage = [[BackgroundUtil new] backgroundImageAccordingToTime];
    backgroundImageView.image = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).backgroundImage;
    [self configureBackground];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showHideMenu];
}

- (void)setupView {
    menuHidden = YES;
    [self refreshTime];
}

- (void)configureBackground {
    __block UIImage *blurredImage;
    dispatch_sync((dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)), ^{
        blurredImage = [[BackgroundUtil new] blurredBackgroundImageForImage:backgroundImageView.image];
    });
    
    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).backgroundImage = blurredImage;
    [UIView animateWithDuration:0.3 animations:^{
        backgroundImageView.image = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).backgroundImage;
    }];
    
//    TODO: For future, when I apply bg change while app is
//    running functionality.
//    
//    // Refresh background image after every 1 minute
//    [self performSelector:@selector(configureBackground) withObject:nil afterDelay:60];
}

- (void)refreshTime {
    dispatch_async(dispatch_get_main_queue(), ^{
      NSDate *now = [NSDate date];
      NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
      [outputFormatter setDateFormat:@"hh:mm:ss a"];
      NSString *newDateString = [outputFormatter stringFromDate:now];
      timeLabel.text = newDateString;
    });

    // refresh every 1 second
    [self performSelector:@selector(refreshTime) withObject:nil afterDelay:1];
}

- (void)showHideMenu {
    if (menuHidden) {
        [UIView animateWithDuration:0.3 animations:^{
            slidingMenuLeadingConstraint.constant += 60;
            [slidingMenuView layoutIfNeeded];
        }];
        [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            menuContainerView.alpha = 1;
        } completion:nil];

        
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            menuContainerView.alpha = 0;
        }];
        [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            slidingMenuLeadingConstraint.constant -= 60;
            [slidingMenuView layoutIfNeeded];
        } completion:nil];
    }
    menuHidden = !menuHidden;
}

#pragma mark - Button Actions

- (IBAction)menuButtonAction:(id)sender {
    [self showHideMenu];
}

- (IBAction)setAlarmButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"setAlarmSegue" sender:self];
}

- (IBAction)settingsButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"settingsSegue" sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
