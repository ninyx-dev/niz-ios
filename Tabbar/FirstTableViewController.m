//
//  FirstTableViewController.m
//  Tabbar
//
//  Created by HYUN MUK CHO on 12. 6. 26..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "FirstTableViewController.h"
#import "FirstTableViewCell.h"

@interface FirstTableViewController ()

@end

@implementation FirstTableViewController
@synthesize arrData, receiveData, xmlParser, currentKey;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    receiveData = [[NSMutableData alloc] init];
    
    
    [self getxmlFromServer];
    arrData = [[NSMutableArray alloc] init];
//    arrData = [NSMutableArray arrayWithObjects:@"test1",
//              @"test2",
//              @"test3",
//              @"test4",
//              @"test5",
//              nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FirstCell";
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        
    }else {
        cell.titleLabel.text = [arrData objectAtIndex:indexPath.row];
    }
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}






-(void)getxmlFromServer
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:TRUE];
    
    NSURL * url = [NSURL URLWithString:@"http://www.niz.co.kr/ip/xml.asp?area=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection){
        //receiveData = [[NSMutableData data] retain];
    }else{
        [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:FALSE];
    }
}
-(void)parseXmlData:(NSData *)dataVictim
{

    xmlParser = [[NSXMLParser alloc] initWithData:dataVictim];
    [xmlParser setDelegate:self];
    //[xmlParser setShouldResolveExternalEntities:NO];
    [xmlParser parse];
}

-(void)drawRecordList
{
    
}


-(void)parser:(NSXMLParser*)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    //self.currentKey = nil;
    if(currentKey == nil)
        currentKey = [[NSMutableString alloc]initWithCapacity:10];
    
    NSLog(@"didStartElement : %@", elementName);
    //self.currentKey = elementName;
}
-(void)parser:(NSXMLParser*)parser foundCharacters:(NSString*)characters{

    
    NSLog(@"foundCharacters : %@", characters);
    [currentKey appendString:characters];
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    NSLog(@"didEndElement : %@", elementName);
    
    //[self drawRecordList];
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
    //inParse = FALSE;
    if ([currentKey length] > 0) {
        [arrData addObject:currentKey];
        
        //[currentKey release];
        currentKey = [[NSMutableString alloc]initWithCapacity:10];
        
    }
}





-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
    //[connection release];
    //[receiveData release];
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data{
    [receiveData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection*)connection{
    
    NSString * test2 = [[NSString alloc] initWithData:receiveData encoding:0x80000000 + kCFStringEncodingDOSKorean];
    //NSLog(@"test2 : %@", test2);
    
    //test2 = @"<?xml version='1.0' encoding='euc-kr'?><result><tablerow><content>한글</content></tablerow></result>";
    
    test2 = [test2 stringByReplacingOccurrencesOfString:@"euc-kr" withString:@"UTF-8"];
    //NSLog(@"test2 : %@", test2);
    
    
       NSLog(@"test2 : %@", test2);
    NSData * uData = [test2 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"xml : %@", [[NSString alloc] initWithData:uData encoding:NSUTF8StringEncoding]);
    
    [self parseXmlData:uData];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
    [self.tableView reloadData];
}
@end
