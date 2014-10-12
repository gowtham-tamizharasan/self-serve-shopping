//
//  checkOutCellTableViewCell.h
//  BarcodeScanner
//
//  Created by Mano bharathi on 10/11/14.
//  Copyright (c) 2014 Draconis Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface checkOutCellTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *qtyLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
