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
        
        self.channelName = dictionary[@"name"];
        self.channelNumber = dictionary[@"num"];
        self.channelID = dictionary[@"id"];
        //NSString *string1 = LOGO_IMAGE_URL;
        //NSString *string3 = @".png";
        //NSString *logoString = [NSString stringWithFormat: @"%@%@%@", string1, self.channelID, string3];
        self.imageURL =[self makeCombinedLogoString];
        //[NSString stringWithFormat:@"%@",logoString];
        self.isHD = dictionary[@"hd"];
        self.isFavourite = dictionary[@"fav"];
        
        self.pp =dictionary[@"pp"];
        self.q =dictionary[@"q"];
        self.streamingURL =[NSURL URLWithString: [self makeCombinedStreamingString]];
    }
    
    return self;
}

#pragma mark - Private API

- (NSString*) makeCombinedLogoString {
    
    NSString *string1 = LOGO_IMAGE_URL;
    NSString *string3 = @".png";
    NSString *logoString = [NSString stringWithFormat: @"%@%@%@", string1, self.channelID, string3];
    return logoString;
}

- (NSString*) makeCombinedStreamingString {
    
    NSString *string1 = STREAM_URL_BASE;
    NSString *string2 = @"&channel";
    NSString *string3 = @"&stream";
    NSString *streamingString = [NSString stringWithFormat: @"%@%@%@%@%@", string1,string2,self.pp,string3,self.q];
    return streamingString;
}

@end
