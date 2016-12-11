//
//  SideListViewController.m
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import "SideListViewController.h"
#import "PlayerViewController.h"
#import "ChannelTableViewCell.h"
#import "DataFetcher.h"
#import "Channel.h"
#import "Constants.h"

@interface SideListViewController() <UITableViewDataSource, UITableViewDelegate, ChannelFetcherDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) Channel *selectedChannel;
@end

@implementation SideListViewController

#pragma mark - Properties

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
    }
    return _itemsArray;
}

- (NSArray *)favouriteChannelsArray {
    NSMutableArray *resultsArray = [[NSMutableArray alloc] init];
    
    for (Channel *channel in self.itemsArray) {
        if (channel.isFavourite == YES) {
            [resultsArray addObject:channel];
        }
    }
    
    return resultsArray;
}

- (NSArray *)hdChannelsArray {
    NSMutableArray *resultsArray = [[NSMutableArray alloc] init];
    
    for (Channel *channel in self.itemsArray) {
        if (channel.isHD == YES) {
            [resultsArray addObject:channel];
        }
}

    return resultsArray;
}

#pragma mark - Actions

- (IBAction)favouriteButtonTapped {
    [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_MENU_NOTIFICATION object:nil];
}

- (IBAction)hdButtonTapped {
    [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_MENU_NOTIFICATION object:nil];
    
    [self.itemsArray removeAllObjects];
    [self.tableView reloadData];
}

- (IBAction)allChannelsButtonTapped {
    [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_MENU_NOTIFICATION object:nil];
}

- (IBAction)swipeHandler:(UISwipeGestureRecognizer *)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_MENU_NOTIFICATION object:nil];
}

#pragma mark - Private API

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserverForName:CHANNELS_DOWNLOADED
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note)
     {
         if (note.object && [note.object isKindOfClass:[NSDictionary class]]) {
             NSDictionary *dictionary = (NSDictionary *)note.object;
             
             [self.itemsArray removeAllObjects];
             
             NSLog(@"%@", dictionary[@"channels_list"]);
             
             for (NSDictionary *channelDictionary in dictionary[@"channels_list"]) {
                 Channel *channel = [[Channel alloc] initWithDictionary:channelDictionary];
                 [self.itemsArray addObject:channel];
             }
             
             [self.tableView reloadData];
             
             // Inform user that channels are downloaded
             [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_MENU_NOTIFICATION object:nil];
         } else {
             NSLog(@"Error occured");
         }
     }];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [[DataFetcher sharedInstance] fetchDataFromURL:JSON_URL];
    [self registerForNotifications];
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(swipeHandler:)];
    gestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:gestureRecognizer];

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChannelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Channel *channel = [self.itemsArray objectAtIndex:indexPath.row];
    cell.channelNumberLabel.text = channel.channelNumber;
    cell.channelNameLabel.text = channel.channelName;
    cell.channelImageView.imageURL = channel.imageURL;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Channel *channel = [self.itemsArray objectAtIndex:indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_MENU_NOTIFICATION object:nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:channel forKey:@"Channel"];
    [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_CHANNEL_NOTIFICATION object:nil userInfo:dictionary];
}

@end
