//
//  PurchaseItemDetailsController.h
//  Store
//
//  Created by Ilya Dolgopolov on 23.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseItemDetailsController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceForOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityInBulk;
@property (weak, nonatomic) IBOutlet UILabel *priceInBulk;

@property (nonatomic) NSInteger articul;


@end
