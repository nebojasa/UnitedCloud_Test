//
//  PlayerViewController.m
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import "PlayerViewController.h"
#import "Constants.h"


@interface PlayerViewController ()
@end

@implementation PlayerViewController

#pragma mark - Actions

- (IBAction)menuButtonTapped {
    [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_MENU_NOTIFICATION object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
