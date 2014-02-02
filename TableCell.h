//
//  TableCell.h
//  GetTweets
//
//  Created by admin on 01.02.14.
//  Copyright (c) 2014 Eugene Bereza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UIImageView *image;

@end
