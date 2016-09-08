#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BackgroundUtil : NSObject

- (UIImage *)backgroundImageAccordingToTime;
- (UIImage *)blurredBackgroundImageForImage:(UIImage *)backgroundImage;

@end
