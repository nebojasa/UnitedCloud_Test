//
//  SideListViewController.m
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import "SideListViewController.h"
#import "DataFetcher.h"
#import "Channel.h"
#import "Constants.h"

@interface SideListViewController() <UITableViewDataSource, UITableViewDelegate, ChannelFetcherDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@end

@implementation SideListViewController

#pragma mark - Properties

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
    }
    
    return _itemsArray;
}

#pragma mark - Private API

//- (void)loadData {
//    [[DataFetcher sharedInstance] fetchDataFromURL:JSON_URL withCompletion:^(BOOL success, NSDictionary *dictionary, NSError *error)
//     {
//         if (success) {
//             [self.itemsArray removeAllObjects];
//             
//             NSLog(@"%@", dictionary[@"channels_list"]);
//             
//             for (NSDictionary *channelDictionary in dictionary[@"channels_list"]) {
//                 Channel *channel = [[Channel alloc] initWithDictionary:channelDictionary];
//                 [self.itemsArray addObject:channel];
//             }
//             
//             [self.tableView reloadData];
//         } else {
//             if (error) {
//                 NSLog(@"Error occured: %@", error.localizedDescription);
//             }
//         }
//     }];
//}
//


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
                 Channel *article = [[Channel alloc] initWithDictionary:channelDictionary];
                 [self.itemsArray addObject:article];
             }
             
             [self.tableView reloadData];
             
             // Inform user that news are downloaded
             [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_MENU_NOTIFICATION object:nil];
         } else {
             NSLog(@"Error occured");
         }
     }];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. BLOCK
    //[self loadData];
    
    [[DataFetcher sharedInstance] fetchDataFromURL:JSON_URL];
    // 2. NOTIFICATION
    [self registerForNotifications];
    
    // 3. DELEGATE
    //[Fetcher sharedInstance].delegate = self;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Channel *channel = [self.itemsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = channel.channelName;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Channel *channel = [self.itemsArray objectAtIndex:indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CLOSE_MENU_NOTIFICATION object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_ARTICLE_NOTIFICATION object:channel];
}

//#pragma mark - FetcherDelegate
//
//- (void)dataFetched:(NSDictionary *)dictionary {
//    if (dictionary) {
//        [self.itemsArray removeAllObjects];
//        
//        NSLog(@"%@", dictionary[@"channels_list"]);
//        
//        for (NSDictionary *channelDictionary in dictionary[@"channels_list"]) {
//            Channel *channel = [[Channel alloc] initWithDictionary:channelDictionary];
//            [self.itemsArray addObject:channel];
//        }
//        
//        [self.tableView reloadData];
//    } else {
//        NSLog(@"Error occured");
//    }
//}

@end
