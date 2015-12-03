//
//  WorkAPI.m
//  testVKproject
//
//  Created by Alexonis on 02.12.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import "WorkAPI.h"
#import "User.h"

@implementation WorkAPI
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
    NSError *error;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:dataVK
                          options:kNilOptions
                          error:&error];
    arrUser=json[@"response"][@"items"];
    NSLog(@"%lu",(unsigned long)[arrUser count]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MyNotification" object:nil];
}


-(NSMutableArray*) parser
{
    
    NSMutableArray *arFin=[NSMutableArray arrayWithCapacity:[arrUser count]];
    
    for( NSDictionary *friend in arrUser)
    {
        User *user=[[User alloc] init];
        user.fullName=[NSString stringWithFormat:@"%@ %@",
              [friend objectForKey:@"first_name"],
              [friend objectForKey:@"last_name"]];
        user.imgUrl=[NSString stringWithFormat:@"%@",
                      [friend objectForKey:@"photo_50"]];
        user.usId=[NSString stringWithFormat:@"%@",
                     [friend objectForKey:@"id"]];
        [arFin addObject:user];
    }
    return arFin;
}
-(void)getUsers
{
    dataVK = [NSMutableData data];
    NSString *urlS=[NSString stringWithFormat:
                    @"https://api.vk.com/method/friends.get?user_id=%@&fields=nickname,photo_50&v=5.40&access_token=%@",self.user_Id,self.access_token];
    NSURL *url=[NSURL URLWithString:urlS];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSURLConnection *theConnect=[[NSURLConnection alloc]
                                 initWithRequest:request delegate:self];
    [theConnect start];
    
}

@end
