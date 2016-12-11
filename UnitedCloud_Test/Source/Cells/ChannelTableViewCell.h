//
//  ChannelTableViewCell.h
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Channel.h"
#import "AsyncImageView.h"

@interface ChannelTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet AsyncImageView *channelImageView;
@property (weak, nonatomic) IBOutlet UILabel *channelNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *channelNumberLabel;
//@property (weak, nonatomic) IBOutlet UIImage *hd;
//@property (weak, nonatomic) IBOutlet UIImage *fav;

@property (strong, nonatomic) Channel *channel;

@end
