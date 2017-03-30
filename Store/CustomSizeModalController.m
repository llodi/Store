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


- (instancetype) initWithPresentedViewController:(UIViewController *)presentedViewController
                        presentingViewController:(UIViewController *)presentingViewController
                                         options:(UICustomTransitionOptions)options
                            withHorizontalInsets: (CGFloat) insets
                                      viewHeight: (CGFloat) height
{
    
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if(self) {
        self.options = options;
        [self setupDimmingView];
        self.horizontalInsets = insets;
        self.viewHeight = height;
        
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
            frameHeight = self.viewHeight;
            y = height / 2 - (frameHeight / 2);
            break;
        case UICustomTransitionFromBottomOptions:
            frameHeight = self.viewHeight;
            y = height - self.viewHeight - self.horizontalInsets;
            break;
        default:
            return self.containerView.bounds;
            break;
    }
    
    return CGRectMake(self.horizontalInsets, y, width - (self.horizontalInsets * 2), frameHeight);
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
