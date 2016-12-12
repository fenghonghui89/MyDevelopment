//
//  ViewController.m
//  FacebookTest
//
//  Created by 冯鸿辉 on 2016/12/5.
//  Copyright © 2016年 HanyAppDev. All rights reserved.
//

#import "ViewController.h"
#import <TwitterKit/TwitterKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  [self customLogin];
}

#pragma mark - method
-(void)customEmbeddedTweet{

  // TODO: Base this Tweet ID on some data from elsewhere in your app
  [[[TWTRAPIClient alloc] init] loadTweetWithID:@"631879971628183552" completion:^(TWTRTweet *tweet, NSError *error) {
    if (tweet) {
      TWTRTweetView *tweetView = [[TWTRTweetView alloc] initWithTweet:tweet style:TWTRTweetViewStyleRegular];
      tweetView.center = CGPointMake(self.view.center.x, self.topLayoutGuide.length + tweetView.frame.size.height / 2);
      [self.view addSubview:tweetView];
    } else {
      NSLog(@"Tweet load error: %@", [error localizedDescription]);
    }
  }];

}

-(void)customLogInWithTwitter{

  TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
    if (session) {
      // Callback for login success or failure. The TWTRSession
      // is also available on the [Twitter sharedInstance]
      // singleton.
      //
      // Here we pop an alert just to give an example of how
      // to read Twitter user info out of a TWTRSession.
      //
      // TODO: Remove alert and use the TWTRSession's userID
      // with your app's user model
      NSString *message = [NSString stringWithFormat:@"@%@ logged in! (%@)",
                           [session userName], [session userID]];
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logged in!"
                                                      message:message
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
      [alert show];
    } else {
      NSLog(@"Login error: %@", [error localizedDescription]);
    }
  }];
  
  // TODO: Change where the log in button is positioned in your view
  logInButton.center = self.view.center;
  [self.view addSubview:logInButton];

}


-(void)customLogin{

  // Add a button to the center of the view to show the timeline
  UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
  [button setTitle:@"Show Timeline" forState:UIControlStateNormal];
  [button sizeToFit];
  button.frame = CGRectMake(10, 50, 100, 20);
  [button addTarget:self action:@selector(customLoginAction) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
}

-(void)customEmbeddedTimeline{
  // Add a button to the center of the view to show the timeline
  UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
  [button setTitle:@"Show Timeline" forState:UIControlStateNormal];
  [button sizeToFit];
  button.frame = CGRectMake(10, 50, 100, 20);
  [button addTarget:self action:@selector(showTimeline) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];

}

-(void)customMonetizeWithMoPub{

  // Add a button to the center of the view to show the timeline
  UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
  [button setTitle:@"Show Timeline" forState:UIControlStateNormal];
  [button sizeToFit];
  button.frame = CGRectMake(10, 50, 100, 20);
  
  [button addTarget:self action:@selector(showTimeline1) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];

}

#pragma mark - action
-(void)customLoginAction{
  [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
    if (session) {
      NSLog(@"signed in as %@", [session userName]);
    } else {
      NSLog(@"error: %@", [error localizedDescription]);
    }
  }];
}
- (void)showTimeline {
  // Create an API client and data source to fetch Tweets for the timeline
  TWTRAPIClient *client = [[TWTRAPIClient alloc] init];
  TWTRCollectionTimelineDataSource *datasource = [[TWTRCollectionTimelineDataSource alloc] initWithCollectionID:@"539487832448843776" APIClient:client];
  TWTRTimelineViewController *controller = [[TWTRTimelineViewController alloc] initWithDataSource:datasource];
  // Create done button to dismiss the view controller
  UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissTimeline)];
  controller.navigationItem.leftBarButtonItem = button;
  // Create a navigation controller to hold the
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
  [self showDetailViewController:navigationController sender:self];
}

- (void)showTimeline1 {
  
  // Create an API client and data source to fetch Tweets for the timeline
  TWTRAPIClient *client = [[TWTRAPIClient alloc] init];
  TWTRUserTimelineDataSource *dataSource = [[TWTRUserTimelineDataSource alloc] initWithScreenName:@"fabric" APIClient:client];
  
  // Replace `TWTRMoPubSampleAdUnitID` with your MoPub native ad unit ID
  TWTRMoPubAdConfiguration *adConfig = [[TWTRMoPubAdConfiguration alloc] initWithAdUnitID:TWTRMoPubSampleAdUnitID keywords:nil];
  TWTRTimelineViewController *controller = [[TWTRTimelineViewController alloc] initWithDataSource:dataSource adConfiguration:adConfig];
  
  // Create done button to dismiss the view controller
  UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissTimeline)];
  controller.navigationItem.leftBarButtonItem = button;
  
  // Create a navigation controller to hold the
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
  
  [self showDetailViewController:navigationController sender:self];
}

- (void)dismissTimeline {
  [self dismissViewControllerAnimated:YES completion:nil];
}


@end
