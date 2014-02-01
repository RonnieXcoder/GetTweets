//
//  ProfileViewController.m
//  GetTweets
//
//  Created by admin on 30.01.14.
//  Copyright (c) 2014 Eugene Bereza. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[_bioField layer] setBorderColor: [[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0] CGColor]];
    [[_bioField layer] setBorderWidth:1];
    [[_bioField layer] setCornerRadius:5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToFeed:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
