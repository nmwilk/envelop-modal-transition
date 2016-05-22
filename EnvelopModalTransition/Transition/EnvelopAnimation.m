//
// Created by Neil on 17/05/2016.
// Copyright (c) 2016 acme. All rights reserved.
//

#import "EnvelopAnimation.h"

@implementation EnvelopAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

    CGRect toViewEndFrame = [transitionContext finalFrameForViewController:
                                                       [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey]];

    CGRect fromViewEndFrame = [transitionContext finalFrameForViewController:
                                                         [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey]];

    [transitionContext.containerView addSubview:toView];

    UIView *headerView = [self getHeaderView:transitionContext];
    UIView *mainView = [self getLowerView:transitionContext];

    CGFloat statusBarHeight = [self getSystemBarHeight];
    CGFloat mainViewSlidePosition = toViewEndFrame.size.height / 2;

    if (self.presenting) {
        headerView.frame = CGRectMake(0, -headerView.frame.size.height, toViewEndFrame.size.width, headerView.frame.size.height);
        mainView.frame = CGRectMake(0, mainViewSlidePosition, toViewEndFrame.size.width, mainView.frame.size.height);
    } else {
        headerView.frame = CGRectMake(0, statusBarHeight, toViewEndFrame.size.width, headerView.frame.size.height);
    }

    toView.alpha = 0.0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:self.presenting ? UIViewAnimationOptionCurveEaseOut : UIViewAnimationOptionCurveEaseIn
                     animations:^{

                         fromView.alpha = 0.0;
                         toView.alpha = 1.0;

                         if (self.presenting) {
                             toView.frame = toViewEndFrame;
                             mainView.frame = CGRectMake(0, headerView.frame.size.height, toViewEndFrame.size.width, mainView.frame.size.height);
                             headerView.frame = CGRectMake(0, 0, toViewEndFrame.size.width, headerView.frame.size.height);
                         } else {
                             mainView.frame = CGRectMake(0, mainViewSlidePosition, fromViewEndFrame.size.width, mainView.frame.size.height);
                             headerView.frame = CGRectMake(0, -(headerView.frame.size.height + statusBarHeight), fromViewEndFrame.size.width, headerView.frame.size.height);
                         }

                     }
                     completion:^(BOOL finished) {
                         BOOL success = ![transitionContext transitionWasCancelled];

                         if ((self.presenting && !success) || (!self.presenting && success)) {
                             [toView removeFromSuperview];
                         }
                         [transitionContext completeTransition:YES];
                     }];
}

- (CGFloat)getSystemBarHeight {
    CGSize size = [UIApplication sharedApplication].statusBarFrame.size;
    return MIN(size.width, size.height);
}

- (UIView *)getLowerView:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *viewController = self.presenting ?
            [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] :
            [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIView *lowerView;
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *) viewController;
        lowerView = ((UIViewController *) navController.viewControllers[0]).view;
    } else {
        lowerView = viewController.view;
    }

    return lowerView;
}

- (UIView *)getHeaderView:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *viewController = self.presenting ?
            [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] :
            [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    return [viewController isKindOfClass:[UINavigationController class]] ?
            ((UINavigationController *)viewController).navigationBar :
            nil;
}

@end