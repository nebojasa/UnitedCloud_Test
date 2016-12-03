//
//  DataFetcher.m
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import "DataFetcher.h"

@implementation DataFetcher

#pragma mark - Designated Initializer

+ (instancetype)sharedInstance {
    static DataFetcher *sharedManager;
    
    @synchronized(self)	{
        if (sharedManager == nil) {
            sharedManager = [[DataFetcher alloc] init];
        }
    }
    
    return sharedManager;
}

#pragma mark - Public API

- (void)fetchDataFromURL:(NSString *)url withCompletion:(CompletionHandler)handler {
    dispatch_queue_t downloadQueue = dispatch_queue_create("ChannelsDownloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        NSError *serializationError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
        
        if (serializationError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(NO, nil, serializationError);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(YES, dictionary, nil);
            });
        }
    });
}

- (void)fetchDataFromURL:(NSString *)url {
    dispatch_queue_t downloadQueue = dispatch_queue_create("ChannelsDownloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        NSError *serializationError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
        
        if (serializationError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(dataFetched:)]) {
                    [self.delegate dataFetched:nil];
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:CHANNELS_DOWNLOADED object:nil];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(dataFetched:)]) {
                    [self.delegate dataFetched:dictionary];
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:CHANNELS_DOWNLOADED object:dictionary];
            });
        }
    });
    
}

@end
