//
//  User.h
//  testVKproject
//
//  Created by Alexonis on 02.12.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface User : NSObject
{
    NSArray *imgsUsr_url;
    NSArray *imgeUs;
@public
    UIImage *avaImg;
}

@property NSString *fullName;
@property NSString *imgUrl;
@property NSString *usId;
-(NSMutableArray*)downloadImages:(NSArray*)arrIm;
-(void)avaDownload;
-(NSString*) getName;

@end
