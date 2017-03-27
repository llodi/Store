//
//  OrderPositionCell.m
//  Store
//
//  Created by Ilya Dolgopolov on 24.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "OrderPositionCell.h"
#import "NSString+formatter.h"

@implementation OrderPositionCell

- (void) setOrderItem:(OrderItem *)orderItem {
    _orderItem = orderItem;
    [self updateUI];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void) updateUI {
    self.articulLabel.text = @"";
    self.nameLabel.text = @"";
    self.totalLabel.text = @"";
    self.quantityLabel.text = @"";
    
    self.articulLabel.text = [NSString formateInt: self.orderItem.articul];
    self.nameLabel.text = self.item.title;
    self.totalLabel.text = [NSString formateDouble:[self.orderItem totalForItem:self.item]];
    self.quantityLabel.text = [NSString formateInt:self.orderItem.quantity];
}

@end
