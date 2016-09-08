#import "DateTimeUtil.h"
#import "SetAlarmViewController.h"
#import "AppDelegate.h"

@interface SetAlarmViewController () <UIPickerViewDataSource,
UIPickerViewDelegate>

@end

@implementation SetAlarmViewController {
    
    __weak IBOutlet UIPickerView *timePicker;
    __weak IBOutlet UIImageView *backgroundImageView;
    
    NSString *str;
    NSDate *dateTime;
}


#pragma mark - Utility

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureBackground];
    [self initializeTimePicker];
}

- (void)initializeTimePicker {
    
}

- (void)configureBackground {
    [UIView animateWithDuration:0.2 animations:^{
        backgroundImageView.image = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).backgroundImage;
    }];
    
    //Refresh background image after every 1 minute
    [self performSelector:@selector(configureBackground) withObject:nil afterDelay:20];
}

- (void)formatDateFromString:(NSString *)dateStringFromPicker {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"IST"]];
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *todayString = [dateFormat stringFromDate:currentDate];
    
    
    // Convert string to date object
    [dateFormat setDateFormat:@"HH:mm:ss"];
    NSDate *selectedDate = [dateFormat dateFromString:dateStringFromPicker];
    NSString *selectedDateString = [dateFormat stringFromDate:selectedDate];
    
    
    NSString *finalDateString = [todayString stringByReplacingCharactersInRange:NSMakeRange(11, 8) withString:selectedDateString];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"IST"]];
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    dateTime = [dateFormat dateFromString:finalDateString];
    NSLog(@"%@",dateTime);
}

#pragma mark - Button Actions

- (IBAction)setAlarm:(UIButton *)sender {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = dateTime;
    localNotification.alertBody = [NSString stringWithFormat:@"Alert Fired at %@", dateTime];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}


#pragma mark - PickerView

// Method to define how many columns to show
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// Method to define the numberOfRows in a component using the array.
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [DateTimeUtil getArrayHours].count;
    } else {
        return [DateTimeUtil getArrayMinutes].count;
    }
}

// Method to define height of row
- (CGFloat)pickerView:(UIPickerView *)pickerView
rowHeightForComponent:(NSInteger)component {
    return 90.0f;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    NSString *hoursStr = [NSString
                          stringWithFormat:@"%@", [[DateTimeUtil getArrayHours]
                                                   objectAtIndex:[pickerView
                                                                  selectedRowInComponent:0]]];
    if (hoursStr.length < 2) {
        hoursStr = [NSString stringWithFormat:@"0%@", hoursStr];
    }
    
    NSString *minsStr = [NSString
                         stringWithFormat:@"%@", [[DateTimeUtil getArrayMinutes]
                                                  objectAtIndex:[pickerView
                                                                 selectedRowInComponent:1]]];
    if (minsStr.length < 2) {
        minsStr = [NSString stringWithFormat:@"0%@", minsStr];
    }
    
    NSString *dateStringFromPicker = [NSString stringWithFormat:@"%@:%@:00",hoursStr,minsStr];
    
    [self formatDateFromString:dateStringFromPicker];
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    UILabel *titleLabel = (UILabel *)view;
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont fontWithName:@"Apple SD Gothic Neo" size:40];// [UIFont systemFontOfSize:40];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    switch (component) {
        case 0: {
            NSString *hourString = [NSString
                                    stringWithFormat:@"%@",
                                    [[DateTimeUtil getArrayHours] objectAtIndex:row]];
            if (hourString.length < 2) {
                hourString = [NSString stringWithFormat:@"0%@", hourString];
            }
            titleLabel.text = hourString;
            break;
        }
        case 1: {
            NSString *minuteString = [NSString
                                      stringWithFormat:@"%@",
                                      [[DateTimeUtil getArrayMinutes] objectAtIndex:row]];
            if (minuteString.length < 2) {
                minuteString = [NSString stringWithFormat:@"0%@", minuteString];
            }
            titleLabel.text = minuteString;
            break;
        }
    }
    return titleLabel;
}

@end
