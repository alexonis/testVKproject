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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // Загрузка в другом потоке
        [self getMySelf];
        dispatch_async(dispatch_get_main_queue(), ^{ //Показываем фотографию в основном потоке

        });
    });
    //[self takeMyname];
   // [self takeMyImg];
      return self;
}
-(void) getMySelf
{
    
    userDefaults= [NSUserDefaults standardUserDefaults];
    Vk = [NSMutableData data];
    NSString *urlS=[NSString stringWithFormat:
                    @"https://api.vk.com/method/friends.get?user_id=%@&fields=nickname,photo_50&v=5.40&access_token=%@",[userDefaults objectForKey:@"myId"],[userDefaults objectForKey:@"token"]];
    NSURL *url=[NSURL URLWithString:urlS];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSURLConnection *theConnect=[[NSURLConnection alloc]
                                 initWithRequest:request
                                 delegate:self];
    [theConnect start];
}
-(void) takeMyname
{
    NSLog(@"%@ !",jsonMY[@"response"]);
    self.firstName= [NSString stringWithFormat:@"%@",jsonMY[@"first_name"]];
    self.lastName= [NSString stringWithFormat:@"%@",jsonMY[@"last_name"]];
}
-(void)takeMyImg
{
    
    NSURL *urlIM=[NSURL URLWithString:jsonMY[@"photo_50"]];
    NSData *dataIm=[NSData dataWithContentsOfURL:urlIM];
    myImage=[UIImage imageWithData:dataIm];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"!!!");
    NSError *error;
    jsonMY= [NSJSONSerialization
                            JSONObjectWithData:Vk
                            options:kNilOptions
                            error:&error];
    NSLog(@"%@ !",[[NSString alloc] initWithData:Vk encoding:NSUTF8StringEncoding]);
}
@end
