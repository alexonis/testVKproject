//
//  WorkAPI.h
//  testVKproject
//
//  Created by Alexonis on 02.12.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface WorkAPI : NSObject<NSURLConnectionDelegate>
{
    NSMutableData* dataVK;
    NSArray* arrUser;
@public
    BOOL *flag;
}
@property NSString* access_token;
@property NSString* user_Id;
-(NSMutableArray*) parser;
-(void)getUsers;
-(void)getImages;
@end

