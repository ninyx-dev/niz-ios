//
//  SecondViewController.h
//  Tabbar
//
//  Created by HYUN MUK CHO on 12. 6. 26..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UIWebViewDelegate>{
    UIWebView *webView;
    UIProgressView *progressView;
    
    NSMutableData *receivedData;
    int totalfilesize;
    int filesizereceived;
    float filepercentage;
    
}

@property (nonatomic, retain) IBOutlet UIWebView * webView;
@property (nonatomic, retain) IBOutlet UIProgressView * progressView;
@end
