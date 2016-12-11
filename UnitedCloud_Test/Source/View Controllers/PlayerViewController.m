//
//  PlayerViewController.m
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import "PlayerViewController.h"
#import "DataFetcher.h"
#import "Constants.h"
#import "SideListViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

static const NSString *ItemStatusContext;

@interface PlayerViewController ()
@property (strong, nonatomic) NSMutableArray *itemsArray;
@end

@implementation PlayerViewController

#pragma mark - Private API

- (void)registerForNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserverForName:OPEN_CHANNEL_NOTIFICATION
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note)
     {
         if (self.player.currentItem != nil) {
             [self stopVideo];
         } else {

         NSURL *url = [NSURL URLWithString:@"http://devstreaming.apple.com/videos/wwdc/2016/102w0bsn0ge83qfv7za/102/hls_vod_mvp.m3u8"];
         AVAsset *avAsset = [AVAsset assetWithURL:url];
         AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithAsset:avAsset];
         AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
         AVPlayerViewController *playerViewController = [AVPlayerViewController new];
         playerViewController.player = player;
         playerViewController.showsPlaybackControls = YES;
         playerViewController.videoGravity = AVLayerVideoGravityResizeAspectFill;
         playerViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
         [self.view addSubview:playerViewController.view];
         [player play];
         // register notificaton for end of movie
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stopVideo:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
         }
     }];
}

- (void)stopVideo {
    
    // react by setting the video back to 0
    
    [self.player seekToTime:kCMTimeZero];
    
    // then pause it
    [self.player pause];
}

- (void)stopVideo:(NSNotification *)notification {
    
    // react by setting the video back to 0
    
    [self.player seekToTime:kCMTimeZero];
    
    // then pause it
    [self.player pause];
}

- (void)repeatVideo:(NSNotification *)notification {
    
    // react by setting the video back to 0
    
    [self.player seekToTime:kCMTimeZero];
    
    // then play it again
    [self.player play];
}

- (void)definesGestureRecognizers{
    UISwipeGestureRecognizer *gestureRecognizerH = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(swipeHandlerHorizontal:)];
    gestureRecognizerH.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:gestureRecognizerH];

    UISwipeGestureRecognizer *gestureRecognizerD = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(swipeHandlerVertical:)];
    gestureRecognizerD.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:gestureRecognizerD];
    
    
}

#pragma mark - Properties

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
    }
    return _itemsArray;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Actions

- (IBAction)swipeHandlerHorizontal:(UISwipeGestureRecognizer *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_MENU_NOTIFICATION object:nil];
}

- (IBAction)swipeHandlerVertical:(UISwipeGestureRecognizer *)sender {
    //[[NSNotificationCenter defaultCenter] postNotificationName:CLOSE_MENU_NOTIFICATION object:nil];
    

}

#pragma mark - ViewLifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForNotifications];
    [self definesGestureRecognizers];
}

@end
