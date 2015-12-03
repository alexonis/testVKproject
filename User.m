//
//  User.m
//  testVKproject
//
//  Created by Alexonis on 02.12.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import "User.h"

@interface User()
@end
@implementation User

-(NSMutableArray*)downloadImages:(NSArray*)arrIm
{
    return nil;
}
-(NSString*) getName
{
    return self.fullName;
}
-(void)avaDownload
{
    NSURL *urlIM=[NSURL URLWithString:self.imgUrl];
    NSData *dataIm=[NSData dataWithContentsOfURL:urlIM];
    avaImg=[UIImage imageWithData:dataIm];
       [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageDownload" object:nil];
}
@end