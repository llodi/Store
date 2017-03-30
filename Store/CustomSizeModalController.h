//
//  CustomSizeModalController.h
//  Store
//
//  Created by Ilya Dolgopolov on 25.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UICustomTransitionOptions) {
    UICustomTransitionFromBottomOptions,
    UICustomTransitionCentrallyOptions
};

@interface CustomSizeModalController : UIPresentationController

@property (nonatomic) CGFloat horizontalInsets;
@property (nonatomic) CGFloat viewHeight;


- (instancetype) initWithPresentedViewController:(UIViewController *)presentedViewController
                        presentingViewController:(UIViewController *)presentingViewController
                                         options:(UICustomTransitionOptions)options
                            withHorizontalInsets: (CGFloat) insets
                                      viewHeight: (CGFloat) height;

@end
