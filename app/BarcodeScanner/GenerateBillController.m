//
//  GenerateBillController.m
//  BarcodeScanner
//
//  Created by Mano bharathi on 10/11/14.
//  Copyright (c) 2014 Draconis Software. All rights reserved.
//

#import "GenerateBillController.h"

@interface GenerateBillController ()

@end

@implementation GenerateBillController
@synthesize QRcode;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
  
    
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(10, 10, 300, 500)];
    
    NSString *iframe = [NSString stringWithFormat:@"<iframe src='%@'class=\'lichess-tv-iframe\' allowtransparency=\'true\' frameBorder=\'5\' style=\'width: 300px\' title=\'Lichess free online chess\'></iframe>",QRcode];
    
    NSString *HTML = [NSString stringWithFormat:@"<HTML><BODY>%@</BODY></HTML>", iframe];
    
    //[web setScalesPageToFit:YES];
    
    [web loadHTMLString:HTML baseURL:nil];
    [self.view addSubview:web];

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

@end
