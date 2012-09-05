//
//  FourthTableViewController.h
//  Tabbar
//
//  Created by HYUN MUK CHO on 12. 6. 27..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourthTableViewController : UITableViewController
{
    NSMutableArray * arrData;
    NSMutableData * receiveData;
    NSXMLParser *xmlParser;
    
    //bool inParse;
    NSMutableString *currentKey;
}


@property (nonatomic, retain) NSMutableArray * arrData;
@property (nonatomic, retain) NSMutableData * receiveData;
@property (nonatomic, retain) NSXMLParser *xmlParser;
@property (nonatomic, retain) NSMutableString *currentKey;


-(void)getxmlFromServer;
-(void)parseXmlData:(NSData *)dataVictim;
-(void)drawRecordList;

@end
