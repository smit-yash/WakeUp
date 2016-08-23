#import "DateTimeUtil.h"

static NSMutableArray *arrayHours;
static NSMutableArray *arrayMinutes;

@implementation DateTimeUtil

+ (void)initialize {
    //initialize arrays
    arrayHours = [[NSMutableArray alloc] init];
    arrayMinutes = [[NSMutableArray alloc] init];
    NSString *strVal = [[NSString alloc] init];
    
    for (int i=0; i<60; i++) {
        strVal = [NSString stringWithFormat:@"%d", i];
        
        //Create array with 0-12 hours
        if (i < 24) {
            [arrayHours addObject:strVal];
        }
        
        //create arrays with 0-60 mins
        [arrayMinutes addObject:strVal];
    }
}

+ (NSArray *)getArrayHours {
    return arrayHours;
}

+ (NSArray *)getArrayMinutes {
    return arrayMinutes;
}

/**
 *  Method to convert duration in minutes to hh mm format
 */
+ (NSString *)convertedDuration:(NSInteger)durationInMinutes {
    NSInteger hours = durationInMinutes/60;
    NSInteger minutes = durationInMinutes%60;
    
    return [NSString stringWithFormat:@"%ldh %ldm",(long)hours,(long)minutes];
}

/**
 *  Method to convert duration to duration in minutes
 */
+ (NSInteger)durationInMinutesFromDuration:(NSString *)durationText {
    NSArray *timeArray = [durationText componentsSeparatedByString:@"h"];
    NSInteger hours = [[timeArray firstObject] integerValue];
    NSString *minutesString = [timeArray lastObject];
    NSInteger minutes = [[minutesString substringToIndex:minutesString.length-1] integerValue];
    NSInteger durationInMinutes = (hours*60) + minutes;
    
    return durationInMinutes;
}

@end
