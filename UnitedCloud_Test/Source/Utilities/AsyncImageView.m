//
//  AsyncImageView.m
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 04/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import "AsyncImageView.h"

@implementation AsyncImageView

#pragma mark - Properties

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("ImageDownloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageURL]];
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
    });
}

@end
