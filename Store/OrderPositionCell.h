//
//  OrderPositionCell.h
//  Store
//
//  Created by Ilya Dolgopolov on 24.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderItem.h"
#import "Item.h"

@interface OrderPositionCell : UITableViewCell

@property (nonatomic) OrderItem *orderItem;
@property (nonatomic) Item *item;


@property (weak, nonatomic) IBOutlet UILabel *articulLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;


@end
