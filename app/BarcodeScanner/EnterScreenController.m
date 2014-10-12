//
//  EnterScreenController.m
//  BarcodeScanner
//
//  Created by Mano bharathi on 10/11/14.
//  Copyright (c) 2014 Draconis Software. All rights reserved.
//

#import "EnterScreenController.h"
#import "ViewController.h"
@interface EnterScreenController ()
{
    
}
@end

@implementation EnterScreenController
@synthesize activity;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     msgData=[[NSMutableData alloc]init];
    
    activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activity.frame = CGRectMake(130, 240, 60, 60);
    activity.layer.cornerRadius = 8.0f;
    activity.layer.masksToBounds = YES;
    activity.tintColor = [UIColor darkGrayColor];
    activity.color = [UIColor whiteColor];
    activity.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:activity];
    
    
 

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startShopping:(id)sender {
    
    
    [activity startAnimating];
    NSString *url_string =@"http://192.168.137.9:3000/api/generateSession";
    
    
    NSURL *visitorDetailUrl=[NSURL URLWithString:url_string];
    
    NSMutableURLRequest *getFloatDetailsRequest = [NSMutableURLRequest requestWithURL:visitorDetailUrl];
    NSURLConnection *theConnection;
    theConnection =[[NSURLConnection alloc] initWithRequest:getFloatDetailsRequest delegate:self];

   
    }

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1
{
    
    [msgData appendData:data1];
    
}




- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [activity startAnimating];
         NSString *receivedString=[[NSMutableString alloc]initWithData:msgData encoding:NSUTF8StringEncoding];
    if(receivedString==nil)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oop!" message:@"Something went wrong Try again Later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
     
    }
    else
    {
        ViewController *view = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        view.sessionID = receivedString;
        [self presentViewController:view animated:YES completion:nil];
        
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
    }
   
    
}

-(void)connection:(NSURLConnection *)connection   didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oop!" message:@"Something went wrong Try again Later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
    [alert show];
     [activity startAnimating];
}

@end
