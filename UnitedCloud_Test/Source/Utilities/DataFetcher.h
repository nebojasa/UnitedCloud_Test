//
//  DataFetcher.h
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const CHANNELS_DOWNLOADED = @"CHANELS_DOWNLOADED";

@protocol ChannelFetcherDelegate <NSObject>

@optional
- (void)dataFetched:(NSDictionary *)dictionary;
@end

typedef void (^CompletionHandler)(BOOL success, NSDictionary *dictionary, NSError *error);

@interface DataFetcher : NSObject

@property (weak, nonatomic) id<ChannelFetcherDelegate> delegate;
+ (instancetype)sharedInstance;
- (void)fetchDataFromURL:(NSString *)url withCompletion:(CompletionHandler)handler;
- (void)fetchDataFromURL:(NSString *)url;
@end
