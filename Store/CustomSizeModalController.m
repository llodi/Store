//
//  CustomSizeModalController.m
//  Store
//
//  Created by Ilya Dolgopolov on 25.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "CustomSizeModalController.h"

@interface CustomSizeModalController()

@property (nonatomic) UIView *dimmingView;
@property (nonatomic) UICustomTransitionOptions options;

@end

@implementation CustomSizeModalController

- (instancetype) initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController options:(UICustomTransitionOptions)options
{
    
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if(self) {
        self.options = options;
        [self setupDimmingView];
    }
    return self;
}

#pragma mark - UIPresentationController methods

- (CGRect)frameOfPresentedViewInContainerView {
    CGFloat height = self.containerView.bounds.size.height;
    CGFloat width = self.containerView.bounds.size.width;
    
    if (!height) return CGRectZero;
    if (!width) return CGRectZero;
    CGFloat frameHeight = height;
    CGFloat y = 0;
    switch (self.options) {
        case UICustomTransitionCentrallyOptions:
            frameHeight = 160;//height * 0.25;
            y = height / 2 - (frameHeight / 2);
            break;
        case UICustomTransitionFromBottomOptions:
            frameHeight = height * 0.25;
            y = height * 0.75;
        default:
            return self.containerView.bounds;
            break;
    }
    
    return  CGRectMake(10, y - 10, width - 10 - 10, frameHeight);
}

- (void)presentationTransitionWillBegin {
    
    UIView *containerView = self.containerView;
    
    UIViewController *presentedViewController = self.presentedViewController;
    
    [self.dimmingView setFrame:containerView.bounds];
    self.dimmingView.alpha = 0.0;
    
    [self.containerView addSubview:self.dimmingView];//insertSubview:self.dimmingView atIndex:0];

    [presentedViewController.transitionCoordinator
     animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context)
    {
        [self.dimmingView setAlpha:0.85];
    } completion:nil];
}

- (void) dismissalTransitionWillBegin {
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context)
     {
         [self.dimmingView setAlpha:0.0];
     } completion:nil];
}

- (void)containerViewWillLayoutSubviews {
    [self.dimmingView setFrame:self.containerView.bounds];
    [self.presentedView setFrame:self.frameOfPresentedViewInContainerView];
}

#pragma mark - setup dimming view

- (UIView *)dimmingView {
    if(!_dimmingView) _dimmingView = [[UIView alloc] init];
    return _dimmingView;
}

- (void) setupDimmingView {
    self.dimmingView.translatesAutoresizingMaskIntoConstraints = NO;
    self.dimmingView.backgroundColor = [UIColor blackColor];
    self.dimmingView.alpha = 0.85;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.dimmingView addGestureRecognizer:recognizer];
}

- (void) handleTap: (UITapGestureRecognizer *) recognizer {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
