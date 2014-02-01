//
//  GTViewController.h
//  GetTweets.
//
//  Created by admin on 28.01.14.
//  Copyright (c) 2014 Eugene Bereza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTViewController :UIViewController {

    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
    IBOutlet UILabel *twitterLink;
    IBOutlet UIImageView *logo;
    IBOutlet UIActivityIndicatorView *activityIndicator;

}

- (IBAction)usernameFieldDesmiss:(id)sender;
- (IBAction)passwordFieldDesmiss:(id)sender;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
- (IBAction)SignIn:(id)sender;
- (void)showErrorMessageBox:(NSString*)message;


@end
