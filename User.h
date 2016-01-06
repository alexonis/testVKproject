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
@public   UIImage *avaImg;
}
@property int colvoImg;
@property NSArray *imgsUsr_url;
@property NSArray *msgHist;
@property NSArray *imageUser;
@property NSString *fullName;
@property NSString *imgUrl;
@property NSString *usId;
-(UIImage*)imgDownload:(NSString*)imgsUr;
-(NSString*) getName;
-(void) getMessage;
-(void)sendMsg:(NSString*) message;
-(void)avaDownload;
-(void)getUserImages:(int) imgNext;

@end
