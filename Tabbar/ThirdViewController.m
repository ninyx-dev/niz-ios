//
//  ThirdViewController.m
//  Tabbar
//
//  Created by HYUN MUK CHO on 12. 6. 26..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
@synthesize webView, progressView;


- (void)viewDidLoad
{
    NSURL * url = [NSURL URLWithString:@"http://www.twitour.com/m/page/main.html"];
    NSURLRequest * requestURL = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestURL];
    webView.scalesPageToFit = YES;
    [webView setDelegate:self];
    
    receivedData = [[NSMutableData alloc] init];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:requestURL delegate:self];
    [connection start];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}






- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}






-(void)webViewDidStartLoad:(UIWebView *)webView{
    progressView.progress = 0;
    [progressView setHidden:false];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    progressView.progress = 100;
    [progressView setHidden:TRUE];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    progressView.progress= 0;
}







-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    totalfilesize = [response expectedContentLength];
    [receivedData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    filesizereceived += [data length];
    filepercentage = (float)filesizereceived / (float)totalfilesize;
    progressView.progress = filepercentage;
    
    [receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection{

    progressView.progress = 100;
    [progressView setHidden:TRUE];
    //[connection release];
}





@end
