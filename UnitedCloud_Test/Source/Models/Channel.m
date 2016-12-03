//
//  Channel.m
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import "Channel.h"

@implementation Channel

#pragma mark - Designated Initializer

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.channelName = dictionary[@"name"];
        self.channelNumber = dictionary[@"num"];
        //self.imageURL = dictionary[@"imageUrl"];
        self.isHD = dictionary[@"hd"];
        self.isFavourite = dictionary[@"fav"];
    }
    
    return self;
}

@end
