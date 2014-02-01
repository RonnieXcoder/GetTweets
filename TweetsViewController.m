//
//  TweetsViewController.m
//  GetTweets
//
//  Created by admin on 29.01.14.
//  Copyright (c) 2014 Eugene Bereza. All rights reserved.
//

#import "TweetsViewController.h"
#import "ProfileViewController.h"
#import "WebViewController.h"
#import "TableCell.h"
#import "TableCell2.h"
#import "UIImageView+WebCache.h"

@interface TweetsViewController () {
  
}

@end

@implementation TweetsViewController


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
    
   /* UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tweetsTableViewCellTapped:)];
    tapGesture.numberOfTapsRequired = 1;
    [tweetsTableView addGestureRecognizer:tapGesture];*/

}

- (IBAction)tweetsTableViewCellTextTapped:(id)sender
{
    
    NSIndexPath *indexPath = [tweetsTableView indexPathForSelectedRow];
    
    if ((indexPath.row%2) != 0) return;
    
    NSURL *url = [NSURL URLWithString:@"http://twitter.com"];
    
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    
    if (canOpen)
    {
    
      //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://google.com"]];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        WebViewController *web = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
        
        [web setModalPresentationStyle:UIModalPresentationFullScreen];
        
        [self presentViewController:web animated:YES completion:nil];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [web.webView loadRequest:request];

    
    }
    else
    {
            NSLog(@"error");
    }

}

- (IBAction)tweetsTableViewCellTapped:(id)sender
{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ProfileViewController *profile = [storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    
    [profile setModalPresentationStyle:UIModalPresentationFullScreen];
    
    [self presentViewController:profile animated:YES completion:nil];
        
    //NSString *className = NSStringFromClass([sender class]);

    //NSString *className = NSStringFromClass([((UIGestureRecognizer*) sender).view class]);
    
    
    if (((UIGestureRecognizer*) sender).state == UIGestureRecognizerStateEnded)
    {
       
        @try
        {
        
            CGPoint location = [((UIGestureRecognizer*) sender) locationInView:tweetsTableView];
        
            NSIndexPath *indexPath = [tweetsTableView indexPathForRowAtPoint:location];
        
            TableCell* cell = (TableCell*)[tweetsTableView cellForRowAtIndexPath:indexPath];
        
            profile.nameField.text = cell.username.text;
        
            NSDictionary *t = [_twitt objectAtIndex:indexPath.row/2];

            id userurl = [[t objectForKey:@"user"] objectForKey:@"url"];
            id userloc = [[t objectForKey:@"user"] objectForKey:@"location"];
            id userdes = [[t objectForKey:@"user"] objectForKey:@"description"];
            
            (userurl != [NSNull null]) ? (profile.webSiteField.text = userurl) : (profile.webSiteField.text = @"");
            (userloc != [NSNull null]) ? (profile.locationField.text = userloc) : (profile.locationField.text = @"");
            (userdes != [NSNull null]) ? (profile.bioField.text = userdes) : (profile.bioField.text = @"");
        
            NSURL *url = [NSURL URLWithString:[[t objectForKey:@"user"] objectForKey:@"profile_image_url"]];
        
            profile.profileImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                
        
            
        }
        @catch (NSException *exception)
        {
            NSLog(@"%@", exception.debugDescription);
        }

    }
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_twitt count] * 2;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *t = [_twitt objectAtIndex:indexPath.row/2];
 
   
    if ((indexPath.row%2) == 0)
    {
        
        static NSString* CellIndetifier1 = @"Cell";
        
        TableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndetifier1 forIndexPath:indexPath];
        
        cell.username.text = [[t objectForKey:@"user"] objectForKey:@"name"];
        cell.date.text = [t objectForKey:@"created_at"];
        
        [cell.image setImageWithURL:[NSURL URLWithString:[[t objectForKey:@"user"] objectForKey:@"profile_image_url"]]
                       placeholderImage:[UIImage imageNamed:@"twitter.png"]];

        //[cell setBackgroundColor:[UIColor colorWithRed:.8 green:.8 blue:1 alpha:5]];
        
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    else
    {
        static NSString* CellIndetifier2 = @"Cell2";
        
        TableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:CellIndetifier2 forIndexPath:indexPath];

        cell.message.text = [t objectForKey:@"text"];
        
        [cell setBackgroundColor:[UIColor clearColor]];
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row%2) == 0)
        return 45;
    else
        return 80;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentStateChanged:(id)sender
{
    
    switch(timelineControl.selectedSegmentIndex)
    {
        case 0: NSLog(@"0");
            break;
        case 1: NSLog(@"1");;
            break;
        case 2: NSLog(@"2");;
            break;
    }

}
@end
