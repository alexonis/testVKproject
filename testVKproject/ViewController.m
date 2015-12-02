//
//  ViewController.m
//  testVKproject
//
//  Created by Alexonis on 20.11.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerSecond.h"
@interface ViewController ()

@end
const NSInteger tagWebView=1024;

@implementation ViewController
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self->dataVK setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self->dataVK appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed: %@", [error description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:dataVK
                          options:kNilOptions
                          error:&error];
    NSArray* arrayItms=json[@"response"][@"items"];
    ViewControllerSecond *vc;
    vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerSecond"];
    vc.ArrayItems=arrayItms;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webVi;
{
    NSString *curUrl=webVi.request.URL.absoluteString;
    NSRange range1=[curUrl rangeOfString:@"&expires"];
    NSRange range2=[curUrl rangeOfString:@"access_token="];
    NSRange range3=[curUrl rangeOfString:@"user_id="];
    access_token=[[curUrl substringToIndex:range1.location]
                  substringFromIndex:(range2.location+range2.length)];
    user_Id=[curUrl substringFromIndex:
             (range3.location+range3.length)];
    [[self.view viewWithTag:tagWebView] removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
                         @"https://oauth.vk.com/authorize?client_id=%i&display=mobile&redirect_uri=https://vk.com/callback&scope=friends,offline&response_type=token&v=5.40",clientID];
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
}
-(IBAction)GetFriends:(id) sender
{
    self->dataVK = [NSMutableData data];
    NSString *urlS=[NSString stringWithFormat:
                    @"https://api.vk.com/method/friends.get?user_id=%@&fields=nickname,photo_50&v=5.40&access_token=%@",user_Id,access_token];
    NSURL *url=[NSURL URLWithString:urlS];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSURLConnection *theConnect=[[NSURLConnection alloc]
                                 initWithRequest:request delegate:self];
    [theConnect start];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
