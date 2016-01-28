//
//  MyStrig.h
//  testVKproject
//
//  Created by Alexonis on 07.01.16.
//  Copyright © 2016 Alexonis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Messages : NSObject
@property NSString* mainString;
@property NSString* outString;
@property NSString* idString;
@property NSMutableArray* attachImgURL;
@property NSMutableArray* arrayOfImages;
-(void)TakeAttachementImg;

@end
