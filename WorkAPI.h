//
//  WorkAPI.h
//  testVKproject
//
//  Created by Alexonis on 02.12.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "User.h"

@interface WorkAPI : NSObject<NSURLConnectionDelegate>
{
    NSMutableData* dataVK;
    NSArray* arrUserJson;
    NSArray* arrMsg;
    NSMutableArray* arrUserJsonImg;
@public
    BOOL *flag;
}
@property NSString* user_Id;
@property User* usertmp;
-(NSMutableArray*) parserUser;
-(NSMutableArray*) parserImages;
-(NSMutableArray*) parserMessag;
-(void)getMessag:(NSString*)idUser;
-(void)getUsers;
-(void)getImages:(int) imgNext;
-(void)sendMsg:(NSString*)message andId:(NSString*)idUser;
@end

