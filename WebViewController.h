//
//  WebViewController.h
//  GetTweets
//
//  Created by admin on 01.02.14.
//  Copyright (c) 2014 Eugene Bereza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)backToFeed:(id)sender;

@end
