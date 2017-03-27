//
//  ItemsQuantityController.h
//  Store
//
//  Created by Ilya on 24.03.17.
//  Copyright © 2017 llodi. All  reserved.
//

#import <UIKit/UIKit.h>
#import "OrderItem.h"

@protocol ItemsQuantity <NSObject>

- (void) getOrderItem: (OrderItem *) orderItem;


@optional
- (void) getQuantity: (NSInteger) quantity forArticul: (NSInteger) articul;


@end

@interface ItemsQuantityController: UIViewController

@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (nonatomic) NSInteger articul;


@property (nonatomic) id<ItemsQuantity> delegate;

- (IBAction)okAction:(UIButton *)sender;


@end
