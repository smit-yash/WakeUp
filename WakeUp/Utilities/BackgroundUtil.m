#import "BackgroundUtil.h"

#define kMorningImage @"Morning"
#define kDayImage @"Day"
#define kEveningImage @"Evening"
#define kSunsetImage @"Sunset"
#define kNightImage @"Night"

@implementation BackgroundUtil

/**
 *  Method to get background Image according to current time.
 */
- (UIImage *)backgroundImageAccordingToTime {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    NSInteger currentHour = [components hour];
    
    NSString *imageName = @"";
    
    if (currentHour >= 5 && currentHour < 8) {
        //morning image
        imageName = kMorningImage;
    } else if (currentHour >= 8 && currentHour < 17) {
        //day image
        imageName = kDayImage;
    } else if (currentHour >= 17 && currentHour < 19) {
        //evening image
        imageName = kEveningImage;
    } else if (currentHour >= 19 | currentHour < 5) {
        // night image
        imageName = kNightImage;
    }
    
    return [UIImage imageNamed:imageName];
}

- (UIImage *)blurredBackgroundImageForImage:(UIImage *)backgroundImage {
    
    CIImage *imageToBlur = [CIImage imageWithCGImage:backgroundImage.CGImage];
    
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:imageToBlur forKey: @"inputImage"];
    [gaussianBlurFilter setValue:[NSNumber numberWithFloat: 3] forKey: @"inputRadius"]; //change number to increase/decrease blur
    
    CIImage *resultImage = [gaussianBlurFilter valueForKey: @"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:resultImage fromRect:[imageToBlur extent]];
    UIImage *blurredImage = [[UIImage alloc] initWithCGImage:cgImage scale:backgroundImage.scale orientation:UIImageOrientationUp];
    
    return blurredImage;
}

@end
