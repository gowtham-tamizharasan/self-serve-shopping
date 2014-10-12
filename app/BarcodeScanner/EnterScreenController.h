//
//  EnterScreenController.h
//  BarcodeScanner
//
//  Created by Mano bharathi on 10/11/14.
//  Copyright (c) 2014 Draconis Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterScreenController : UIViewController

{
   NSMutableData *msgData;   
}
- (IBAction)startShopping:(id)sender;

@property (strong,nonatomic)  UIActivityIndicatorView *activity;

@end
