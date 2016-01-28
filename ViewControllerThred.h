//
//  ViewControllerThred.h
//  testVKproject
//
//  Created by Alexonis on 04.01.16.
//  Copyright © 2016 Alexonis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "TakeMySelf.h"
@interface ViewControllerThred : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property User *userTmp;
@property TakeMySelf *mySelf;
-(void) buttonSendMessage;
-(void) downloadMessage;
-(void) requestMessage;
@end
