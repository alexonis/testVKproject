//
//  MyStrig.m
//  testVKproject
//
//  Created by Alexonis on 07.01.16.
//  Copyright © 2016 Alexonis. All rights reserved.
//

#import "Messages.h"

@implementation Messages

-(void) TakeAttachementImg
{
    NSURL *urlImg;
    NSData *dataImg;
    self.arrayOfImages=[NSMutableArray arrayWithCapacity:[self.attachImgURL count]];
    for ( NSString *urlStr in self.attachImgURL) {
        
        UIImage *imgTmpl;
        urlImg=[NSURL URLWithString:urlStr];
        dataImg=[NSData dataWithContentsOfURL:urlImg];
        imgTmpl=[[UIImage alloc]initWithData:dataImg];
        [self.arrayOfImages addObject:imgTmpl];
    }
    
}

@end
