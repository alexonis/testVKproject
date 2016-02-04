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
@public   UIImage *avaImage;
}
@property int valueImages;
@property NSArray *imagesUser_urls;
@property NSArray *messageHistory;
@property NSArray *imagesUser;
@property NSString *fullName;
@property NSString *imageUrl;
@property NSString *userID;
-(UIImage*)imagesDownload:(NSString*)imgsUr;
-(NSString*) getName;
-(void)getMessage;
-(void)sendMessage:(NSString*) message;
-(void)avaDownload;
-(void)getUserImages:(int) imgNext;
@end
