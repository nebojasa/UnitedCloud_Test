//
//  ContainerViewController.m
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import "ContainerViewController.h"
#import "SideListViewController.h"
#import "PlayerViewController.h"
#import "Constants.h"

@interface ContainerViewController()
@property (strong, nonatomic) SideListViewController *sideListViewController;
@property (strong, nonatomic) UINavigationController *playerNavigationController;
@end

@implementation ContainerViewController

#pragma mark - Private API

- (void)configureSideMenuViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.sideListViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SideListViewController class])];
    
    // View controller containment
    [self addChildViewController:self.sideListViewController];
    [self.view addSubview:self.sideListViewController.view];
    [self.sideListViewController didMoveToParentViewController:self];
}

- (void)configurePlayerViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.playerNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"PlayerNavigationController"];
    
    // View controller containment
    [self addChildViewController:self.playerNavigationController];
    [self.view addSubview:self.playerNavigationController.view];
    [self.playerNavigationController didMoveToParentViewController:self];
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserverForName:OPEN_MENU_NOTIFICATION
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note)
     {
         if (self.sideListViewController.isOpened) {
             [[NSNotificationCenter defaultCenter] postNotificationName:CLOSE_MENU_NOTIFICATION object:nil];
             return;
         }
         
         self.sideListViewController.isOpened = YES;
         
         [UIView animateWithDuration:0.3f
                               delay:0.0f
              usingSpringWithDamping:0.4
               initialSpringVelocity:7.0
                             options:UIViewAnimationOptionCurveEaseInOut
                          animations:^{
                              CGRect frame = self.playerNavigationController.view.frame;
                              frame.origin.x = [UIScreen mainScreen].bounds.size.width - kMenuOffset;
                              self.playerNavigationController.view.frame = frame;
                          }
                          completion:NULL];
     }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:CLOSE_MENU_NOTIFICATION
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note)
     {
         self.sideListViewController.isOpened = NO;
         
         [UIView animateWithDuration:0.3f
                               delay:0.0f
              usingSpringWithDamping:0.4
               initialSpringVelocity:7.0
                             options:UIViewAnimationOptionCurveEaseInOut
                          animations:^{
                              CGRect frame = self.playerNavigationController.view.frame;
                              frame.origin.x = 0;
                              self.playerNavigationController.view.frame = frame;
                          }
                          completion:NULL];
     }];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerForNotifications];
    [self configureSideMenuViewController];
    [self configurePlayerViewController];
}

@end
