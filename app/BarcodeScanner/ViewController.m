/*
 * Copyright 2012 ZXing authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <AudioToolbox/AudioToolbox.h>
#import "ViewController.h"
#import "CheckOutScreenController.h"
@interface ViewController ()
{
    BOOL isdataShown;
    int total;
    NSMutableArray *idArray;
    NSMutableArray *qtyArray;
    NSMutableArray *priceArray;
    NSMutableArray *nameArray;
    int nextProduct;
    int initialMoney;
    NSNumber *productID;
    NSNumber *id_num;
    NSMutableDictionary *jsonValue;
    int priceProduct;
  
}
@property (nonatomic, strong) ZXCapture *capture;
@property (nonatomic, weak) IBOutlet UIView *scanRectView;
@property (nonatomic, weak) IBOutlet UIView *purchaseView;
@property (nonatomic, weak) IBOutlet UILabel *decodedLabel;
@property (nonatomic, weak) IBOutlet UILabel *totalBillLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;

@end

@implementation ViewController
@synthesize sessionID;
#pragma mark - View Controller Methods

- (void)viewDidLoad {
  [super viewDidLoad];
    

    idArray = [[NSMutableArray alloc]init];
    priceArray = [[NSMutableArray alloc]init];
    qtyArray = [[NSMutableArray alloc]init];
    nameArray = [[NSMutableArray alloc]init];
    
    jsonValue = [[NSMutableDictionary alloc]init];

    NSLog(@"Session ID %@",sessionID);
    
  self.purchaseView.hidden =YES;
  self.totalBillLabel.text = @"";
  self.capture = [[ZXCapture alloc] init];
  self.capture.camera = self.capture.back;
  self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
  self.capture.rotation = 90.0f;

    total = 0;
    nextProduct = 0;
    initialMoney = 0;
    
  self.capture.layer.frame = self.view.bounds;
  self.capture.layer.frame = CGRectMake(0, 125, 320, 443);
    NSLog(@"Siz e: %@",NSStringFromCGRect(self.decodedLabel.frame));
  self.scanRectView.layer.frame = CGRectMake(30, 200, 260, 308);
  self.decodedLabel.layer.frame = CGRectMake(30, 90, 260, 510);
  self.decodedLabel.textColor = [UIColor whiteColor];

  [self.view.layer addSublayer:self.capture.layer];
  [self.view bringSubviewToFront:self.scanRectView];
  [self.view bringSubviewToFront:self.decodedLabel];

   msgData=[[NSMutableData alloc]init];
    
    
    //[self showPopup];
    
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

     self.purchaseView.hidden =YES;
  self.capture.delegate = self;
  self.capture.layer.frame = self.view.bounds;
  self.capture.layer.frame = CGRectMake(0, 125, 320, 443);
    


  CGAffineTransform captureSizeTransform = CGAffineTransformMakeScale(320 / self.view.frame.size.width, 480 / self.view.frame.size.height);
  self.capture.scanRect = CGRectApplyAffineTransform(self.scanRectView.frame, captureSizeTransform);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark - Private Methods

- (NSString *)barcodeFormatToString:(ZXBarcodeFormat)format {
  switch (format) {
    case kBarcodeFormatAztec:
      return @"Aztec";

    case kBarcodeFormatCodabar:
      return @"CODABAR";

    case kBarcodeFormatCode39:
      return @"Code 39";

    case kBarcodeFormatCode93:
      return @"Code 93";

    case kBarcodeFormatCode128:
      return @"Code 128";

    case kBarcodeFormatDataMatrix:
      return @"Data Matrix";

    case kBarcodeFormatEan8:
      return @"EAN-8";

    case kBarcodeFormatEan13:
      return @"EAN-13";

    case kBarcodeFormatITF:
      return @"ITF";

    case kBarcodeFormatPDF417:
      return @"PDF417";

    case kBarcodeFormatQRCode:
      return @"QR Code";

    case kBarcodeFormatRSS14:
      return @"RSS 14";

    case kBarcodeFormatRSSExpanded:
      return @"RSS Expanded";

    case kBarcodeFormatUPCA:
      return @"UPCA";

    case kBarcodeFormatUPCE:
      return @"UPCE";

    case kBarcodeFormatUPCEANExtension:
      return @"UPC/EAN extension";

    default:
      return @"Unknown";
  }
}

#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
  if (!result) return;

  // We got a result. Display information about the result onscreen.
  NSString *formatString = [self barcodeFormatToString:result.barcodeFormat];
  NSString *display = [NSString stringWithFormat:@"Scanned!\n\nFormat: %@\n\nContents:\n%@", formatString, result.text];
    
    productID = 0;
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    productID = [f numberFromString:[NSString stringWithFormat:@"%@",result.text]];
    
    
   // productID =  doubleValue];
   
  //[self.decodedLabel performSelectorOnMainThread:@selector(setText:) withObject:display waitUntilDone:YES];

  // Vibrate
    
    NSLog(@"ID : %@",result.text);
  
    [self showPopup];
}

-(void)showPopup
{
    if(!isdataShown)
    {
        
    NSString *url_string =[NSString stringWithFormat:@"http://192.168.137.9:3000/getProductDetails/%@",productID];
    NSURL *visitorDetailUrl=[NSURL URLWithString:url_string];
    
    NSMutableURLRequest *getFloatDetailsRequest = [NSMutableURLRequest requestWithURL:visitorDetailUrl];
    NSURLConnection *theConnection;
    theConnection =[[NSURLConnection alloc] initWithRequest:getFloatDetailsRequest delegate:self];
    isdataShown = YES;
    }
}
- (IBAction)addtoCart:(id)sender
{
    self.purchaseView.hidden =YES;
    if(priceProduct==0)
    {
        
    }
    else
    {
          initialMoney = priceProduct;
        
    }
  
   
    
    isdataShown = NO;
    if(total==0)
    {
        total = initialMoney;
    
    }
    else
    {
         total = initialMoney+total;
    }
    
    [nameArray addObject:self.nameLabel.text];
    [qtyArray addObject:self.qtyLabel.text];
    [priceArray addObject:[NSNumber numberWithInt:priceProduct]];
    [idArray addObject:id_num];
    self.totalBillLabel.text = [NSString stringWithFormat:@"%d Rs",total];
     self.qtyLabel.text= @"1";
    self.qtyStepper.value=0;

    


}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1
{
    
    [msgData appendData:data1];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        isdataShown = NO;
    }
    else
    {
        isdataShown = YES;
    }
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
   
    
    NSMutableDictionary *productJson = [NSJSONSerialization
                                 JSONObjectWithData:msgData //1
                                 options:kNilOptions
                                 error:&error];
    if(productJson==nil)
    {
          isdataShown = YES;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oop!" message:@"Something went wrong Try again Later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
        msgData = nil;
        msgData=[[NSMutableData alloc]init];
    }
    else
    {
         isdataShown = NO;
        if(!isdataShown)
        {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            
            [self.view bringSubviewToFront:self.purchaseView];
            self.purchaseView.hidden =NO;
            self.nameLabel.text = [productJson objectForKey:@"name"];
            self.descriptionLabel.text = [productJson objectForKey:@"description"];
            self.priceLabel.text = [NSString stringWithFormat:@"%@",[productJson objectForKey:@"price"]];
            initialMoney=[[productJson objectForKey:@"price"]integerValue];
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            id_num = [f numberFromString:[NSString stringWithFormat:@"%@",[productJson objectForKey:@"_id"]]];
            
            isdataShown = YES;
            //productJson = nil;
            msgData = nil;
            msgData=[[NSMutableData alloc]init];
            
        }
        
    }
    
}


- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int statusCode = [httpResponse statusCode];
    if(statusCode==200)
    {
        
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oop!" message:@"Something went wrong Try again Later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
        isdataShown = YES;
        
    }
    
    
}

-(void)connection:(NSURLConnection *)connection   didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oop!" message:@"Something went wrong Try again Later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
    [alert show];
    isdataShown = YES;
    
}



- (IBAction)cancel:(id)sender
{
    self.purchaseView.hidden =YES;
    isdataShown = NO;
    self.qtyLabel.text= @"1";
    self.qtyStepper.value=0;
   
}

- (IBAction)checkOut:(id)sender
{
    CheckOutScreenController *check = [[CheckOutScreenController alloc]initWithNibName:@"CheckOutScreenController" bundle:nil];
    check.sessionID =sessionID;
    check.idArray = idArray;
    check.priceArray = priceArray;
    check.nameArray = nameArray;
    check.qtyArray = qtyArray;
    [self presentViewController:check animated:YES completion:nil];
    
}

- (IBAction)goBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)qtyChange:(id)sender {
    
    int count =  self.qtyStepper.value;
    
    if(count==0)
    {
        
    }
    else
    {
        priceProduct = count * initialMoney;
        self.qtyLabel.text = [NSString stringWithFormat:@"%d",count];
    }
    
    
}
@end
