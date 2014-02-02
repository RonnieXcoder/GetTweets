//
//  TweetsViewController.h
//  GetTweets
//
//  Created by admin on 29.01.14.
//  Copyright (c) 2014 Eugene Bereza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
  IBOutlet UITableView *tweetsTableView;
  IBOutlet UISegmentedControl *timelineControl;

}

@property (strong, nonatomic) NSArray *twitt;

- (IBAction)segmentStateChanged:(id)sender;

@end
