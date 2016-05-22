//
//  ModalViewController.m
//  AppleMusicSearchTransition
//
//  Created by Neil on 17/05/2016.
//  Copyright © 2016 acme. All rights reserved.
//

#import "ModalViewController.h"

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.label.text = @"Fade in and slide up";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                          target:self
                                                                                          action:@selector(dismiss)];
}

-(void)dismiss {
    self.label.text = @"Fade out and slide down";
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
