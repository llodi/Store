//
//  TransitorHelper.m
//  Store
//
//  Created by Ilya on 24.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "TransitorHelper.h"

@implementation TransitorHelper


#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UITransitionContextViewControllerKey key = self.isPresenting ? UITransitionContextToViewControllerKey : UITransitionContextFromViewControllerKey;
    UIViewController *controller = [transitionContext viewControllerForKey: key];
    
    if(self.isPresenting) {
        [transitionContext.containerView addSubview:controller.view];
    }
    
    CGRect presentedFrame = [transitionContext finalFrameForViewController:controller];
    CGRect dismissedFrame = presentedFrame;
    
    dismissedFrame.origin.y = transitionContext.containerView.frame.size.height + 20;
    
    CGRect initialFrame = self.isPresenting ? dismissedFrame : presentedFrame;
    CGRect finalFrame = self.isPresenting ? presentedFrame : dismissedFrame;
    
    NSTimeInterval animationDuration = [self transitionDuration:transitionContext];
    
    switch (self.options) {
        case UICustomTransitionCentrallyOptions:
            controller.view.frame = finalFrame;//initialFrame;
            controller.view.transform = CGAffineTransformMakeScale(0, 0);
            break;
        case UICustomTransitionFromBottomOptions:
            controller.view.frame = initialFrame;
            break;
        default:
            controller.view.frame = initialFrame;
            break;
    }
    
    [UIView animateKeyframesWithDuration:animationDuration delay:0 options:0 animations:^{
        
        switch (self.options) {
            case UICustomTransitionCentrallyOptions:
                controller.view.transform = CGAffineTransformIdentity;
                break;
            case UICustomTransitionFromBottomOptions:
                controller.view.frame = finalFrame;
                break;
            default:
                controller.view.frame = finalFrame;
                break;
        }
        
        //controller.view.frame = finalFrame;
        controller.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}


#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source
{
    self.isPresenting = YES;
    CustomSizeModalController *customVC = [[CustomSizeModalController alloc] initWithPresentedViewController:presented presentingViewController:presenting options:self.options];
    return customVC;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresenting = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresenting = NO;
    return self;
}

@end
