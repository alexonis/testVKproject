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
#import "TakeMySelf.h"
@interface ViewController ()
@end
const NSInteger tagWebView=1024;
NSString *access_token;
NSString *user_Id;
UIWebView *webView;
@implementation ViewController
NSUserDefaults *userDefaults;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.toolbarHidden=YES;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundimg.jpg"]];
    self.wAPI=[WorkAPI singleton];
    userDefaults = [NSUserDefaults standardUserDefaults];
    [self connectVK];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)connectVK
{
    int clientID=5155977;
    webView = [[UIWebView alloc] initWithFrame:
               CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webView.tag = tagWebView;
    webView.delegate = self;
    [self.view addSubview:webView];
    NSString *fullURL = [NSString stringWithFormat:
                         @"https://oauth.vk.com/authorize?client_id=%i&display=mobile&redirect_uri=https://vk.com/callback&scope=friends,offline,photos,messages&response_type=token&v=5.40",clientID];
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
}
- (void)webViewDidFinishLoad:(UIWebView *)webVi;
{
    NSString *curUrl=webVi.request.URL.absoluteString;
    NSLog(@"%@", curUrl);
    NSRange range1=[curUrl rangeOfString:@"&expires"];
    NSRange range2=[curUrl rangeOfString:@"access_token="];
    NSRange range3=[curUrl rangeOfString:@"user_id="];
    [userDefaults setObject:[[curUrl substringToIndex:range1.location]
                             substringFromIndex:(range2.location+range2.length)] forKey:@"token"];
    [userDefaults setObject:[curUrl substringFromIndex:
                             (range3.location+range3.length)] forKey:@"myId"];
    [userDefaults synchronize];
    if ([userDefaults objectForKey:@"token"]!=nil) {
    [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
