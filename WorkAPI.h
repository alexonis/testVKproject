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
@property NSString* user_Id;
@property User* usertmp;
@property UIImage* myPhoto;
-(NSMutableArray*) parserUser;
-(NSMutableArray*) parserImages;
-(NSMutableArray*) parserMessage;
-(void)getMessage;
-(void)getUsers;
-(void)getImages:(int) imgNext;
-(void)sendMessage:(NSString*)message andID:(NSString*)idUser;
@end

