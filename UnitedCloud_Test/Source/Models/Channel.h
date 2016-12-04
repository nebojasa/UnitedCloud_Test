//
//  Channel.h
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject
@property (strong, nonatomic) NSString *channelNumber;
@property (strong, nonatomic) NSString *channelName;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *channelID;
@property (nonatomic) BOOL isHD;
@property (nonatomic) BOOL isFavourite;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
