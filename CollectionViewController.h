//
//  CollectionViewController.h
//  testVKproject
//
//  Created by Alexonis on 29.12.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface CollectionViewController : UICollectionViewController

@property User *userI;
@property UIImage *imgsUs;
-(void) downloadImgComplete;
@end
