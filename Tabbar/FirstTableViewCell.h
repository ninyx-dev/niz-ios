//
//  FirstTableViewCell.h
//  Tabbar
//
//  Created by HYUN MUK CHO on 12. 6. 26..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTableViewCell : UITableViewCell
{
    IBOutlet UILabel * titleLabel;
    IBOutlet UIImage * image;
}

@property (nonatomic, retain) IBOutlet UILabel * titleLabel;
@property (nonatomic, retain) IBOutlet UIImage * image;

@end
