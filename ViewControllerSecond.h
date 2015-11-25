//
//  ViewControllerSecond.h
//  testVKproject
//
//  Created by Alexonis on 20.11.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerSecond : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
IBOutlet UITableView *tableView;
}
@property NSArray *ArrayItems;
@end
