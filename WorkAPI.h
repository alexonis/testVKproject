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
    BOOL *flag; // Что за флаг ? Что он делает?
}
@property NSString* access_token; // Лучше записывать так @property(strong, nonotamic) NSString* access_token
@property NSString* user_Id;
-(NSMutableArray*) parser;
-(void)getUsers; // getUser ? get значит получать, что и как мы получаем?
-(void)getImages;
@end

