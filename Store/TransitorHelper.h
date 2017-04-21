//
//  TransitorHelper.h
//  Store
//
//  Created by Ilya on 24.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CustomSizeModalController.h"

@interface TransitorHelper : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

- (instancetype) initWithOption: (UICustomTransitionOption) option
             horizontalInsets: (CGFloat) insets
                   hiewHeight: (CGFloat) height;

@end
