//
//  PlayerViewController.m
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import "PlayerViewController.h"
#import "StreamingCollectionViewCell.h"
#import "Constants.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>



@interface PlayerViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@end

@implementation PlayerViewController

#pragma mark - Properties

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
    }
    return _itemsArray;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
#pragma mark - Actions

- (IBAction)swipeHandler:(UISwipeGestureRecognizer *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_MENU_NOTIFICATION object:nil];
}

#pragma mark - ViewLifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(swipeHandler:)];
    gestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:gestureRecognizer];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StreamingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCell" forIndexPath:indexPath];
    NSURL *url = [[NSURL alloc] initWithString:@"https://s3-eu-west-1.amazonaws.com/alf-proeysen/Bakvendtland-MASTER.mp4"];
    
    // create a player view controller
    AVPlayer *player = [AVPlayer playerWithURL:url];
    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    
    
    //[self.view addSubview:controller.view];
    
    controller.view.frame = CGRectMake(50,50,100,100);
    controller.player = player;
    controller.showsPlaybackControls = YES;
    player.closedCaptionDisplayEnabled = NO;
    [player pause];
    [player play];
    [cell.containerView addSubview:controller.view];
    //cell.channel = self.itemsArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, collectionView.frame.size.height);
}


@end
