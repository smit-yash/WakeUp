#import <Foundation/Foundation.h>

@interface DateTimeUtil : NSObject

+ (NSArray *)getArrayHours;
+ (NSArray *)getArrayMinutes;
+ (NSString *)convertedDuration:(NSInteger)durationInMinutes;
+ (NSInteger)durationInMinutesFromDuration:(NSString *)durationText;

@end
