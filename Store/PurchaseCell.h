//
//  PurchaseCell.h
//  Store
//
//  Created by Ilya on 22.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface PurchaseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemImaveView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceForOnePosition;
@property (weak, nonatomic) IBOutlet UILabel *priceInBulk;

@property (nonatomic) Item *item;

@end
