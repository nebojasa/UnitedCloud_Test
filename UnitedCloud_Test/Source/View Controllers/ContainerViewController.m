//
//  ContainerViewController.m
//  UnitedCloud_Test
//
//  Created by Nebojsa Gujanicic on 03/12/2016.
//  Copyright © 2016 Nebojsa Gujanicic. All rights reserved.
//

#import "ContainerViewController.h"
#import "PlayerViewController.h"
#import "SideListViewController.h"
#import "Constants.h"

@interface ContainerViewController()
@property (strong, nonatomic) UINavigationController *homeNavigationController;
@property (strong, nonatomic) PlayerViewController *playerViewController;
@end

@implementation ContainerViewController

#pragma mark - Public API

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserverForName:OPEN_MENU_NOTIFICATION
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note)
     {
         if (self.playerViewController.isOpened) {
             [[NSNotificationCenter defaultCenter] postNotificationName:CLOSE_MENU_NOTIFICATION object:nil];
             return;
         }
         
         [UIView animateWithDuration:2*kAnimationDuration
                               delay:0.0f
              usingSpringWithDamping:0.6f
               initialSpringVelocity:0.4f
                             options:UIViewAnimationOptionCurveEaseInOut
                          animations:^{
                              CGAffineTransform translation  = CGAffineTransformMakeTranslation(-([UIScreen mainScreen].bounds.size.width), 0.0f);
                              self.homeNavigationController.view.transform = translation;
                          } completion:NULL];
         
         self.playerViewController.isOpened = YES;
     }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:CLOSE_MENU_NOTIFICATION
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note)
     {
         [UIView animateWithDuration:2*kAnimationDuration
                               delay:0.0f
              usingSpringWithDamping:0.6f
               initialSpringVelocity:0.4f
                             options:UIViewAnimationOptionCurveEaseInOut
                          animations:^{
                              self.homeNavigationController.view.transform = CGAffineTransformIdentity;
                          } completion:NULL];
         
         self.playerViewController.isOpened = NO;
     }];
}

#pragma mark - Private API

- (void)configurePlayerViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.playerViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PlayerViewController class])];
    
    // View controller containment
    [self addChildViewController:self.playerViewController];
    [self.view addSubview:self.playerViewController.view];
    [self.playerViewController didMoveToParentViewController:self];
}

- (void)configureHomeNavigationController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.homeNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"HomeNavigationController"];
    
    // Add shadow
    self.homeNavigationController.view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.homeNavigationController.view.layer.shadowOffset = CGSizeZero;
    self.homeNavigationController.view.layer.shadowRadius = 5.0f;
    self.homeNavigationController.view.layer.shadowOpacity = 0.2f;
    
    // View controller containment
    [self addChildViewController:self.homeNavigationController];
    [self.view addSubview:self.homeNavigationController.view];
    [self.homeNavigationController didMoveToParentViewController:self];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerForNotifications];
    [self configurePlayerViewController];
    [self configureHomeNavigationController];
    
}

@end
