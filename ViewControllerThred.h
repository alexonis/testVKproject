//
//  ViewControllerThred.h
//  testVKproject
//
//  Created by Alexonis on 04.01.16.
//  Copyright © 2016 Alexonis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ViewControllerThred : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableView;
    UITextField *textMsg;
    UIButton *sendBtn;
    UIImage *myPhoto;
    UIImage *interPhoto;
    NSMutableArray *historyMessage;
}
@property User *userTmp;
-(void) btnSend;
-(void) downloadMsg;
-(void) requestMesg;
@end
