//
//  User.m
//  testVKproject
//
//  Created by Alexonis on 02.12.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import "User.h"
#import "WorkAPI.h"
@interface User()
@end
WorkAPI *work;
@implementation User

-(UIImage*)imagesDownload:(NSString*)imagesUrls
{
    NSURL *urlIM=[NSURL URLWithString:imagesUrls];
    NSData *dataIm=[NSData dataWithContentsOfURL:urlIM];
    return[UIImage imageWithData:dataIm];
}
-(NSString*) getName
{
    return self.fullName;
}
-(void) getMessage
{
    work=[WorkAPI alloc];
    work.usertmp=self;
    [work getMessage];

}
-(void)avaDownload
{
    NSURL *urlIM=[NSURL URLWithString:self.imageUrl];
    NSData *dataIm=[NSData dataWithContentsOfURL:urlIM];
    avaImage=[UIImage imageWithData:dataIm];
}
-(void)getUserImages:(int) imgNext
{
    work=[WorkAPI alloc];
    work.usertmp=self;
    [work getImages:imgNext];
}
-(void)sendMessage:(NSString *)message
{
    work=[WorkAPI alloc];
    work.usertmp=self;
    [work sendMessage:message andID:self.userID];
}
@end