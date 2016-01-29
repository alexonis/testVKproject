//
//  LongPollServer.m
//  testVKproject
//
//  Created by Alexonis on 28.01.16.
//  Copyright © 2016 Alexonis. All rights reserved.
//

#import "LongPollServer.h"
NSArray *arrayUpdates;
NSMutableData* dataVK;
NSString *longPollServer;
NSString *longPollKey;
NSString *longPollts;
NSDictionary *json;
NSArray *arraytmp;
bool listening;
@implementation LongPollServer
-(LongPollServer*) init
{
    //[self connectToLongPoll];
    return self;
}
-(void) connectToLongPoll
{
    listening=0;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *urlS=[NSString stringWithFormat:
                    @"https://api.vk.com/method/messages.getLongPollServer?need_pts=1&access_token=%@",
                    [userDefaults objectForKey:@"token"]];
    NSURL *url=[NSURL URLWithString:urlS];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSURLConnection *theConnect=[[NSURLConnection alloc]
                                 initWithRequest:request delegate:self];
    [theConnect start];
}
-(void)listeningLongPollServer
{
    listening=1;
    NSString *urlS=[NSString stringWithFormat:
                    @"http://%@?act=a_check&key=%@&ts=%@&wait=25&mode=2",
                    longPollServer,longPollKey,longPollts];
    NSURL *url=[NSURL URLWithString:urlS];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSURLConnection *theConnect=[[NSURLConnection alloc]
                                 initWithRequest:request delegate:self];
    [theConnect start];
}
-(void)parserMessageFromLongPoll{
    
    arrayUpdates=json[@"updates"];
    if ([arrayUpdates count]!=0) {
        arraytmp=arrayUpdates[0];
        switch ([arraytmp[0] integerValue]) {
            case 4:
                NSLog(@"%@",arraytmp[3]);
                break;
                
            default:
                break;
        }
    }
    longPollts=json[@"ts"];
    [self listeningLongPollServer];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [dataVK setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [dataVK appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed: %@", [error description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (listening) {
        NSError *error;
         json= [NSJSONSerialization
                              JSONObjectWithData:dataVK
                              options:kNilOptions
                              error:&error];
        [self parserMessageFromLongPoll];
        NSLog(@"%@",[[NSString alloc] initWithData:dataVK encoding:NSUTF8StringEncoding]);
        //[self listeningLongPollServer];
    }
    else
    {
    NSError *error;
    json = [NSJSONSerialization
                          JSONObjectWithData:dataVK
                          options:kNilOptions
                          error:&error];
        NSLog(@"%@",[[NSString alloc] initWithData:dataVK encoding:NSUTF8StringEncoding]);
    longPollKey=[NSString stringWithFormat:@"%@",json[@"response"][@"key"]];
    longPollServer=[NSString stringWithFormat:@"%@",json[@"response"][@"server"]];
    longPollts=[NSString stringWithFormat:@"%@",json[@"response"][@"ts"]];
    NSLog(@"%@ %@ %@", longPollServer, longPollKey, longPollts);
    [self listeningLongPollServer];
    }
}
@end
