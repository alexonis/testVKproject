//
//  ViewController.h
//  testVKproject
//
//  Created by Alexonis on 20.11.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkAPI.h"
@interface ViewController : UIViewController<UIWebViewDelegate>
-(void)connectVK;
@property WorkAPI *wAPI;
@end
