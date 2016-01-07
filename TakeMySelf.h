//
//  TakeMySelf.h
//  testVKproject
//
//  Created by Alexonis on 07.01.16.
//  Copyright © 2016 Alexonis. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TakeMySelf : NSObject <NSURLConnectionDelegate>
{
@public UIImage *myImage;
}
@property NSString* firstName;
@property NSString* lastName;
@property NSString* myId;
-(TakeMySelf*) init;
-(void)takeMyname;
-(void)takeMyImg;
-(void)getMySelf;
@end
