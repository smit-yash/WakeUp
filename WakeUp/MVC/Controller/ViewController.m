//
//  ViewController.m
//  WakeUp
//
//  Created by Optimus-66 on 7/20/16.
//  Copyright © 2016 Optimus Information Inc. All rights reserved.
//

#import "DateTimeUtil.h"
#import "ViewController.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation ViewController {

    __weak IBOutlet UIPickerView *timePicker;
    NSString *str;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // some code
    // jhgjhg
}

- (void)unusedMethod {
}

#pragma mark - PickerView

// Method to define how many columns to show
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// Method to define the numberOfRows in a component using the array.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [DateTimeUtil getArrayHours].count;
    } else {
        return [DateTimeUtil getArrayMinutes].count;
    }
}

// Method to define height of row
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 120.0f;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *hoursStr = [NSString
        stringWithFormat:@"%@", [[DateTimeUtil getArrayHours] objectAtIndex:[pickerView selectedRowInComponent:0]]];
    if (hoursStr.length < 2) {
        hoursStr = [NSString stringWithFormat:@"0%@", hoursStr];
    }

    NSString *minsStr = [NSString
        stringWithFormat:@"%@", [[DateTimeUtil getArrayMinutes] objectAtIndex:[pickerView selectedRowInComponent:1]]];
    if (minsStr.length < 2) {
        minsStr = [NSString stringWithFormat:@"0%@", minsStr];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    UILabel *titleLabel = (UILabel *)view;
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:50];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
    }

    switch (component) {
    case 0: {
        NSString *hourString = [NSString stringWithFormat:@"%@", [[DateTimeUtil getArrayHours] objectAtIndex:row]];
        if (hourString.length < 2) {
            hourString = [NSString stringWithFormat:@"0%@", hourString];
        }
        titleLabel.text = hourString;
        break;
    }
    case 1: {
        NSString *minuteString = [NSString stringWithFormat:@"%@", [[DateTimeUtil getArrayMinutes] objectAtIndex:row]];
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
