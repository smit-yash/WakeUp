#import "SettingsViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "BackgroundUtil.h"

@interface SettingsViewController ()<AVAudioPlayerDelegate, AVAudioSessionDelegate>

@end

@implementation SettingsViewController {
    __weak IBOutlet UIImageView *backgroundImageView;

    AVAudioPlayer *audioPlayer;
}

#pragma mark - Utility

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self setupVolumeView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureBackground];
}

- (void)configureBackground {
    [UIView animateWithDuration:0.2 animations:^{
        backgroundImageView.image = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).backgroundImage;
    }];
    
    //Refresh background image after every 1 minute
    [self performSelector:@selector(configureBackground) withObject:nil afterDelay:20];
}

- (void)setupVolumeView {
    [self initializeAudioPlayer];
    [self createAndDisplayMPVolumeView];
}

/**
 *  Method used to play audio. To be put in the class from where audio will be played.
 */
- (void)initializeAudioPlayer {
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"FILE_NAME_HERE" ofType:@"EXT_HERE"]];

    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [audioPlayer setNumberOfLoops:2];
    if (error) {
        NSLog(@"Error in audioPlayer: %@", [error localizedDescription]);
    } else {
        audioPlayer.delegate = self;
        [audioPlayer prepareToPlay];
        [audioPlayer play];
    }
}

-(void) createAndDisplayMPVolumeView
{
    // Create a simple holding UIView and give it a frame
    UIView *volumeHolder = [[UIView alloc] initWithFrame: CGRectMake(30, 200, 260, 20)];
    
    // set the UIView backgroundColor to clear.
    [volumeHolder setBackgroundColor: [UIColor clearColor]];
    
    // add the holding view as a subView of the main view
    [self.view addSubview: volumeHolder];
    
    // Create an instance of MPVolumeView and give it a frame
    MPVolumeView *myVolumeView = [[MPVolumeView alloc] initWithFrame: volumeHolder.bounds];
    
    // Add myVolumeView as a subView of the volumeHolder
    [volumeHolder addSubview: myVolumeView];
}

#pragma mark - Actions

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
