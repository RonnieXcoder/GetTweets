//
//  ProfileViewController.h
//  GetTweets
//
//  Created by admin on 30.01.14.
//  Copyright (c) 2014 Eugene Bereza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController {
    
}

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *locationField;
@property (strong, nonatomic) IBOutlet UITextField *webSiteField;
@property (strong, nonatomic) IBOutlet UITextView *bioField;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;

- (IBAction)backToFeed:(id)sender;

@end
