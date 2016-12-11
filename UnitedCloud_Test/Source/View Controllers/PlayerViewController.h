//
//  PlayerViewController.h
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Channel.h"

@interface PlayerViewController : UIViewController
@property (strong, nonatomic) NSMutableArray *channelsArray;
@property (nonatomic) BOOL isOpened;
@property (strong,nonatomic) AVPlayer *player;
@property (strong,nonatomic) AVPlayerItem *playerItem;
@property (strong,nonatomic) Channel *channel;
@end
