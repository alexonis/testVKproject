//
//  ViewControllerSecond.m
//  testVKproject
//
//  Created by Alexonis on 20.11.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import "ViewControllerSecond.h"

@interface ViewControllerSecond ()
@end
const static int tagTbl=666;
User *user;
@implementation ViewControllerSecond

- (void)didGetMyNotification{
    
    arrUsers=[self.wAPI parser];
    [tableView reloadData];
}
-(void)imgOk
{
    //[tableView reloadData];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrUsers count];
}

-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //NSLog(@"%@,  %li",[[arrUsers objectAtIndex:indexPath.row ] getName],(long)indexPath.row);
    NSString *sIdentify=@"friends";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:sIdentify];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:
              UITableViewCellStyleDefault
                                    reuseIdentifier:sIdentify];
    }
    user=[arrUsers objectAtIndex:indexPath.row ];
    cell.textLabel.text=[[arrUsers objectAtIndex:indexPath.row ] getName];
    [[arrUsers objectAtIndex:indexPath.row ] avaDownload];
    cell.imageView.image=user->avaImg;
    return cell;
}

- (void)viewDidLoad {
    self.title=@"Friends";
    [self.wAPI getUsers];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didGetMyNotification)
                                                 name:@"MyNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(imgOk)
                                                 name:@"ImageDownload"
                                               object:nil];
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 70, 400, 660)];
    [self.view addSubview:tableView];
    tableView.tag=tagTbl;
    tableView.delegate=self;
    tableView.dataSource=self;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
