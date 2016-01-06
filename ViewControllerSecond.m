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
@implementation ViewControllerSecond



- (void)viewDidLoad {
    self.title=@"Friends";
    [self.wAPI getUsers];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didGetMyNotification)
                                                 name:@"MyNotification"
                                               object:nil];
    // Хорошее начинание делать UI в коде одобряю
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:tableView];
    tableView.tag=tagTbl;
    tableView.delegate=self;
    tableView.dataSource=self;
    
}


- (void)didGetMyNotification{
    
    arrUsers=[self.wAPI parser];
    [tableView reloadData];
}



#pragma mark - UITableViewDataSource
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrUsers count];
}

-(UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //NSLog(@"%@,  %li",[[arrUsers objectAtIndex:indexPath.row ] getName],(long)indexPath.row);
    NSString *sIdentify=@"friends";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:sIdentify];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:
              UITableViewCellStyleDefault
                                    reuseIdentifier:sIdentify];
    }
    
    User* user= arrUsers[indexPath.row];
    cell.textLabel.text=[[arrUsers objectAtIndex:indexPath.row ] getName];
    cell.imageView.image = [UIImage imageNamed:@"notavatar.jpeg"];// Показываем заглушку если нет основной фотографии
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // Загрузка в другом потоке
           [arrUsers[indexPath.row] avaDownload];
        dispatch_async(dispatch_get_main_queue(), ^{ //Показываем фотографию в основном потоке
              cell.imageView.image=user->avaImg;
        });
    });
    return cell;
}




- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
