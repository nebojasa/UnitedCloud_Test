//
//  Channel.m
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import "Channel.h"
#import "Constants.h"

@implementation Channel

#pragma mark - Designated Initializer

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        NSString *string1 = LOGO_IMAGE_URL;
        NSString *string2 = dictionary[@"id"];
        NSString *string3 = @".png";
        NSString *combinedString = [NSString stringWithFormat: @"%@%@%@", string1, string2, string3];
        self.channelName = dictionary[@"name"];
        self.channelNumber = dictionary[@"num"];
        self.imageURL = combinedString;
        self.isHD = dictionary[@"hd"];
        self.isFavourite = dictionary[@"fav"];
        self.channelID = dictionary[@"id"];
    }
    
    return self;
}

@end
