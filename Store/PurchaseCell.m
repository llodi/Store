//
//  PurchaseCell.m
//  Store
//
//  Created by Ilya on 22.03.17.
//  Copyright © 2017 llodi. All rights reserved.
//

#import "PurchaseCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+formatter.h"

@implementation PurchaseCell

- (void) setItem:(Item *)item {
    _item = item;
    [self updateUI];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void) updateUI {
    self.titleLabel.text = @"";
    self.imageView.image = nil;
    self.priceForOnePosition.text = @"";
    self.priceInBulk.text = @"";
    
    self.titleLabel.text = self.item.title;
    NSURL *url = [[NSURL alloc] initWithString:self.item.stringUrlImagePreview];
    if (url) {
        [self.imageView sd_setImageWithURL:url];
    }
    
    self.priceForOnePosition.text = [NSString formateDouble: self.item.priceForOne];
    self.priceInBulk.text = [NSString formateDouble: self.item.priceInBulk];
    
}

@end
