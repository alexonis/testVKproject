//
//  User.h
//  testVKproject
//
//  Created by Alexonis on 02.12.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    NSString *fullName;
    NSURL *imgUrl;
    NSInteger *usId;
    NSArray *imgsUsr_url;
    NSArray *imges;    
}
-(NSMutableArray*)getImages:(NSArray*)arrIm;
@end
