//
//  GTViewController.m
//  GetTweets.
//
//  Created by admin on 28.01.14.
//  Copyright (c) 2014 Bereza Eugene. All rights reserved.
//

#import "GTViewController.h"
#import "TweetsViewController.h"
#import "STTwitter.h"
#import <Accounts/Accounts.h>
//#import <Social/Social.h>

@interface GTViewController ()

@end

@implementation GTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTapped:)];
    
    tapGesture.numberOfTapsRequired = 1;
    
    twitterLink.userInteractionEnabled = YES;
    
    [twitterLink addGestureRecognizer:tapGesture];
    
}

-(void)labelTapped:(UIGestureRecognizer *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return true;
}

- (IBAction)SignIn:(id)sender
{
  /* STTwitterAPI *twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:@"NFoSEAlH4Lzj2Y700cGhg"
                                                          consumerSecret:@"2XJUcGNXcdRV5lRr0J8vV9sCG8RJSelGgh4shJcLmjI"
                                                                username:usernameField.text
                                                                password:passwordField.text];*/
    
   // STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"NFoSEAlH4Lzj2Y700cGhg" consumerSecret:@"2XJUcGNXcdRV5lRr0J8vV9sCG8RJSelGgh4shJcLmjI"];

 
    
    BOOL connect = [self checkUserHasInternetConnection];
    
    if(connect == NO) {

        [self showErrorMessageBox:@"No Internet Connection."];
        return;
    
    }
    
    [activityIndicator startAnimating];
    
    ACAccountStore *account = [[ACAccountStore alloc] init];
    
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
     {
         
         
         if (granted == YES) {
             
             NSArray *accounts = [account accountsWithAccountType:accountType];
             
             if ([accounts count] > 0) {
                 
                 ACAccount *twitterAccount = [accounts lastObject];
                 
                 STTwitterAPI *twitter = [STTwitterAPI twitterAPIOSWithAccount:twitterAccount];
                 
                 [twitter verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
                        
                        [twitter getHomeTimelineSinceID:nil count:20 successBlock:^(NSArray *statuses) {
                            
                            
//                            NSMutableArray *tweetArray = [[NSMutableArray alloc] initWithCapacity:2];
//                            
//                            NSDictionary *currentObject=[statuses objectAtIndex:0];
//                            
//                            [[currentObject objectForKey:@"user"] objectForKey:@"name"];
//                            
//                            [currentObject objectForKey:@"text"];
//                            
//                            NSDateFormatter *format = [[NSDateFormatter alloc] init];
//                            
//                            [format setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
//                            
//                            NSString *created_at = [currentObject objectForKey:@"created_at"];
//                            
//                            NSDate *date = [format dateFromString:created_at];
//                            
//                            [format stringFromDate:date];
                            
                            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                            
                            TweetsViewController *tweets = [storyboard instantiateViewControllerWithIdentifier:@"TweetsViewController"];
                            
                            [tweets setModalPresentationStyle:UIModalPresentationFullScreen];
                            
                            tweets.twitt = [[NSArray alloc] initWithArray: statuses];
                            
                            [self presentViewController:tweets animated:YES completion:nil];
                            
                        } errorBlock:^(NSError *error) {
                            // ...
                        }];
                        

                  
                } errorBlock:^(NSError *error) {
                  
                      NSLog(@"%@", error.debugDescription);
                      [self showErrorMessageBox:error.debugDescription];
                  
                }];

             }
             else
             {
                 [self showErrorMessageBox:@"There are no Twitter accounts configured. You can add or create a Twitter account in Settings."];
             }
             
         }
         else
         {

             NSLog(@"%@", [error localizedDescription]);
             
         }
         
         [activityIndicator stopAnimating];


        
    }];

}

- (void)showErrorMessageBox:(NSString*)message
{
    
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:message
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    [errorAlert show];

}

- (BOOL) checkUserHasInternetConnection
{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com/"]];
    
    request.timeoutInterval = 10;
    
    [request setHTTPMethod:@"HEAD"];
    
    NSHTTPURLResponse *response;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: nil];
    
    return ([response statusCode] == 200) ? YES : NO;

}

- (IBAction)usernameFieldDesmiss:(id)sender
{
    
    [usernameField resignFirstResponder];
    
}

- (IBAction)passwordFieldDesmiss:(id)sender
{
    
    [passwordField resignFirstResponder];
    
}

@end
