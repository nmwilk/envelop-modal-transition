//
// Created by Neil on 17/05/2016.
// Copyright © 2016 Neil Wilkinson. All rights reserved.
//

#import "EnvelopAnimationDelegate.h"
#import "EnvelopAnimation.h"


@interface EnvelopAnimationDelegate ()
@property(nonatomic, strong) EnvelopAnimation *envelopAnimation;
@end

@implementation EnvelopAnimationDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        _envelopAnimation = [[EnvelopAnimation alloc] init];
    }

    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source {
    self.envelopAnimation.presenting = YES;
    return self.envelopAnimation;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.envelopAnimation.presenting = NO;
    return self.envelopAnimation;
}


- (id <UIViewControllerInteractiveTransitioning>)
interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}


- (id <UIViewControllerInteractiveTransitioning>)
interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

@end