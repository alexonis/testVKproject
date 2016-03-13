//
//  ViewControllerSecond.h
//  testVKproject
//
//  Created by Alexonis on 20.11.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkAPI.h"
#import "User.h"

@interface ViewControllerSecond : UIViewController <UITableViewDataSource, UITableViewDelegate>
-(void)downloadUsersComplete;
-(void) logoutAction;
@property WorkAPI *wAPI;
@end
