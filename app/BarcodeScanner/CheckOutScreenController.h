//
//  CheckOutScreenController.h
//  BarcodeScanner
//
//  Created by Mano bharathi on 10/11/14.
//  Copyright (c) 2014 Draconis Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckOutScreenController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableData *msgData;
}
@property(nonatomic,strong)NSMutableDictionary *finalPurchase;

@property(nonatomic,strong)NSString *sessionID;

@property (weak, nonatomic) IBOutlet UITableView *checkTable;
@property(nonatomic,strong)NSMutableArray *idArray;
@property(nonatomic,strong)NSMutableArray *qtyArray;
@property(nonatomic,strong)NSMutableArray *priceArray;
@property(nonatomic,strong)NSMutableArray *nameArray;
- (IBAction)payNow:(id)sender;

@end
