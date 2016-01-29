//
//  TakeMySelf.m
//  testVKproject
//
//  Created by Alexonis on 07.01.16.
//  Copyright © 2016 Alexonis. All rights reserved.
//

#import "TakeMySelf.h"

@implementation TakeMySelf
NSDictionary *jsonMY;
NSUserDefaults *userDefaults;
NSMutableData*  Vk;
-(TakeMySelf*) init
{
    [self getMySelf];
      return self;
}
-(void) getMySelf
{
    
    userDefaults= [NSUserDefaults standardUserDefaults];
    Vk = [NSMutableData data];
    NSString *urlS=[NSString stringWithFormat:
                    @"https://api.vk.com/method/users.get?user_id=%@&fields=photo_50&v=5.40&access_token=%@",[userDefaults objectForKey:@"myId"],[userDefaults objectForKey:@"token"]];
    NSURL *url=[NSURL URLWithString:urlS];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSURLConnection *theConnect=[[NSURLConnection alloc]
                                 initWithRequest:request
                                 delegate:self];
    [theConnect start];
}
-(void) takeMyname
{
    self.firstName= [NSString stringWithFormat:@"%@",jsonMY[@"response"][0][@"first_name"]];
    self.lastName= [NSString stringWithFormat:@"%@",jsonMY[@"response"][0][@"last_name"]];
}
-(void)takeMyImg
{
    
    NSURL *urlIM=[NSURL URLWithString:jsonMY[@"response"][0][@"photo_50"]];
    NSData *dataIm=[NSData dataWithContentsOfURL:urlIM];
    myImage=[UIImage imageWithData:dataIm];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [Vk setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [Vk appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed: %@", [error description]);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    jsonMY= [NSJSONSerialization
                            JSONObjectWithData:Vk
                            options:kNilOptions
                            error:&error];
    [self takeMyname];
    [self takeMyImg];
}
@end
