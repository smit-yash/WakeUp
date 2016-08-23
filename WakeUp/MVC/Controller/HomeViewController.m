#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController {

    __weak IBOutlet UILabel *timeLabel;
}

#pragma mark - Utility

- (void)viewDidLoad {
    [super viewDidLoad];

    [self refreshTime];
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

#pragma mark - Button Actions

- (void)setAlarmButtonAction {
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
