//
//  ChannelTableViewCell.m
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import "ChannelTableViewCell.h"


@implementation ChannelTableViewCell

#pragma mark - Properties

- (void)setChannel:(Channel *)channel {
    _channel = channel;
    self.channelNameLabel.text = channel.channelName;
    self.channelNumberLabel.text = channel.channelNumber;
    //self.hd = [UIImage imageNamed:[NSString stringWithFormat:@"%.@", channel.isHD]];
    //self.fav = [UIImage imageNamed:[NSString stringWithFormat:@"%.@", channel.isFavourite]];
    self.channelImageView.imageURL = channel.imageURL;
}


@end
