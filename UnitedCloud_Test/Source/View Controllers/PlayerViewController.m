//
//  PlayerViewController.m
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import "PlayerViewController.h"
#import "Constants.h"
#import "SideListViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@implementation PlayerViewController

#pragma mark - Properties

- (NSMutableArray *)channelsArray {
    if (!_channelsArray) {
        _channelsArray = [[NSMutableArray alloc] init];
    }
    return _channelsArray;
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

#pragma mark - Private API

- (void)registerForNotifications {
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(triggerAction:) name:OPEN_CHANNEL_NOTIFICATION object:nil];
}

- (void)triggerAction:(NSNotification *)notification {
    
    NSDictionary *dict = notification.userInfo;
    Channel *channel = [dict valueForKey:@"Channel"];
    AVAsset *avAsset = [AVAsset assetWithURL:channel.streamingURL];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithAsset:avAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerViewController *playerViewController = [AVPlayerViewController new];
    playerViewController.player = player;
    playerViewController.showsPlaybackControls = NO;
    playerViewController.videoGravity = AVLayerVideoGravityResizeAspectFill;
    playerViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:playerViewController.view];
    [player play];
}

- (void)stopVideo:(NSNotification *)notification {
    
    [self.player seekToTime:kCMTimeZero];
    [self.player pause];
}

- (void)repeatVideo:(NSNotification *)notification {

    [self.player seekToTime:kCMTimeZero];
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

#pragma mark - ViewLifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForNotifications];
    [self definesGestureRecognizers];
}

@end
