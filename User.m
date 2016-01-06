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

-(UIImage*)imgDownload:(NSString*)imgsUr
{
    NSURL *urlIM=[NSURL URLWithString:imgsUr];
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
    [work getMessag];

}
-(void)avaDownload
{
    NSURL *urlIM=[NSURL URLWithString:self.imgUrl];
    NSData *dataIm=[NSData dataWithContentsOfURL:urlIM];
    avaImg=[UIImage imageWithData:dataIm];
}
@end