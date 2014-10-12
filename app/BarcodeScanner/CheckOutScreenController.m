//
//  CheckOutScreenController.m
//  BarcodeScanner
//
//  Created by Mano bharathi on 10/11/14.
//  Copyright (c) 2014 Draconis Software. All rights reserved.
//

#import "CheckOutScreenController.h"
#import "checkOutCellTableViewCell.h"
#import "SBJson.h"
#import "SBJsonWriter.h"
#import "GenerateBillController.h"

@interface CheckOutScreenController ()
{
    int delete;
}
@end

@implementation CheckOutScreenController
@synthesize sessionID,idArray,priceArray,nameArray,qtyArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    delete = 10;
    
     msgData=[[NSMutableData alloc]init];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1
{
    
    [msgData appendData:data1];
    
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
      
        
    }
    else
    {
        GenerateBillController *generate = [[GenerateBillController alloc]initWithNibName:@"GenerateBillController" bundle:nil];
        
        generate.QRcode = [productJson objectForKey:@"link"];
        [self presentViewController:generate animated:YES completion:nil];
        
        
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
   
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [nameArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    checkOutCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"checkOut"];
    
    if(!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"checkOutCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"checkOut"];
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"checkOut"];
    }
    cell.nameLab.text = [nameArray objectAtIndex:indexPath.row];
    cell.qtyLab.text = [qtyArray objectAtIndex:indexPath.row];
    cell.priceLabel.text =[NSString stringWithFormat:@"%@",[priceArray objectAtIndex:indexPath.row]];
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES - we will be able to delete all rows
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Perform the real delete action here. Note: you may need to check editing style
    //   if you do not perform delete only.
    NSLog(@"Deleted row.");
    
    [nameArray removeObjectAtIndex:indexPath.row];
    [qtyArray removeObjectAtIndex:indexPath.row];
    [idArray removeObjectAtIndex:indexPath.row];
    [priceArray removeObjectAtIndex:indexPath.row];
    [self.checkTable reloadData];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)payNow:(id)sender {
    
    NSDictionary *uploadDictionary= [[NSMutableDictionary alloc]init];
    
   
    
    NSString *str =@"{\"products\":[";
    
    for(int i=0;i<[nameArray count];i++)
    {
      
    
        
        if(i==[nameArray count]-1)
        {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"{\"id\":%@,\"quantity\":%@,\"price\":%@}",[idArray objectAtIndex:i],[qtyArray objectAtIndex:i],[priceArray objectAtIndex:i]]];
        }
        else
        {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"{\"id\":%@,\"quantity\":%@,\"price\":%@},",[idArray objectAtIndex:i],[qtyArray objectAtIndex:i],[priceArray objectAtIndex:i]]];
        }
        
    }
    
    str = [str stringByAppendingString:@"]}"];
    
    
    uploadDictionary=
    @{
      @"session":sessionID,
      @"product":str
      };
    
    
    NSString *urlString=[NSString stringWithFormat:@"http://192.168.137.9:3000/api/sessionShop"];
    
    NSLog(@"uploadDictionary:%@",uploadDictionary);
    
    SBJsonWriter *jsonWriter=[[SBJsonWriter alloc]init];
    
    NSString *uploadString=[jsonWriter stringWithObject:uploadDictionary];
    
    NSData *postData = [uploadString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSURL *loginUrl=[NSURL URLWithString:urlString];
    
    NSMutableURLRequest *autoPost = [NSMutableURLRequest requestWithURL:loginUrl];
    
    [autoPost setHTTPMethod:@"POST"];
    
    [autoPost setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [autoPost setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [autoPost setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [autoPost setHTTPBody:postData];
    
    NSURLConnection *theConnection;
    
    theConnection =[[NSURLConnection alloc] initWithRequest:autoPost delegate:self];
}
@end
