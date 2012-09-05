//
//  ForthViewController.h
//  tabbar
//
//  Created by jo on 12. 9. 2..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForthViewController : UIViewController<UIWebViewDelegate>{   
   
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
