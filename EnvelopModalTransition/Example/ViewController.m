//
//  ViewController.m
//  AppleMusicSearchTransition
//
//  Created by Neil on 17/05/2016.
//  Copyright © 2016 acme. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"
#import "EnvelopAnimationDelegate.h"

@interface ViewController ()
@property(nonatomic, strong) IBOutlet UIButton *open;
@property(nonatomic, strong) id <UIViewControllerTransitioningDelegate> envelopAnimationDelegate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.open addTarget:self action:@selector(openNextScreen) forControlEvents:UIControlEventTouchUpInside];
}

- (void)openNextScreen {
    self.envelopAnimationDelegate = [[EnvelopAnimationDelegate alloc] init];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:
                                                                                           [[ModalViewController alloc] init]];
    navigationController.transitioningDelegate = self.envelopAnimationDelegate;

    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
