//
//  StreamingCollectionViewCell.h
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 04/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Channel.h"

@interface StreamingCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) Channel *channel;
@end
