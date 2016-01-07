//
//  ViewController.m
//  testVKproject
//
//  Created by Alexonis on 20.11.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerSecond.h"
#import "WorkAPI.h"
#import "User.h"
@interface ViewController ()

@end
const NSInteger tagWebView=1024;

@implementation ViewController
WorkAPI *wAPI;
NSUserDefaults *userDefaults;
- (void)viewDidLoad {
    [super viewDidLoad];
    wAPI=[WorkAPI alloc];
    userDefaults = [NSUserDefaults standardUserDefaults];
    if(([userDefaults objectForKey:@"token"]!=nil)&&([userDefaults objectForKey:@"myId"]!=nil))
    {
        ViewControllerSecond *vc;
        vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerSecond"];
        vc.wAPI=wAPI;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)connectVK:(id)sender
{
    int clientID=5155977;
    webView = [[UIWebView alloc] initWithFrame:
               CGRectMake(0, 60, 450, 500)];
    webView.tag = tagWebView;
    webView.delegate = self;
    [self.view addSubview:webView];
    NSString *fullURL = [NSString stringWithFormat:
                         @"https://oauth.vk.com/authorize?client_id=%i&display=mobile&redirect_uri=https://vk.com/callback&scope=friends,offline,photos,messages&response_type=token&v=5.40",clientID];
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
}

-(IBAction)GetFriends:(id) sender
{
    ViewControllerSecond *vc;
    vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerSecond"];
    vc.wAPI=wAPI;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webVi;
{
    NSString *curUrl=webVi.request.URL.absoluteString;
    NSRange range1=[curUrl rangeOfString:@"&expires"];
    NSRange range2=[curUrl rangeOfString:@"access_token="];
    NSRange range3=[curUrl rangeOfString:@"user_id="];
    [userDefaults setObject:[[curUrl substringToIndex:range1.location]
                             substringFromIndex:(range2.location+range2.length)] forKey:@"token"];
    [userDefaults setObject:[curUrl substringFromIndex:
                             (range3.location+range3.length)] forKey:@"myId"];
    [userDefaults synchronize];
    [[self.view viewWithTag:tagWebView] removeFromSuperview];
}

@end
