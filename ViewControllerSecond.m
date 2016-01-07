//
//  ViewControllerSecond.m
//  testVKproject
//
//  Created by Alexonis on 20.11.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import "ViewControllerSecond.h"
#import "CollectionViewController.h"
#import "ViewControllerThred.h"
#import "TakeMySelf.h"

@interface ViewControllerSecond ()
@end
const static int tagTbl=666;
CollectionViewController *cvc;
TakeMySelf* myself;
@implementation ViewControllerSecond

- (void)viewDidLoad {
    
    self.title=@"Friends";
    [self.wAPI getUsers];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadUsersComplete)
                                                 name:@"GetUserComlete"
                                               object:nil];
    tableView=[[UITableView alloc] initWithFrame:
               CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:tableView];
    tableView.tag=tagTbl;
    tableView.delegate=self;
    tableView.dataSource=self;
    
}
- (void)downloadUsersComplete{
    arrUsers=[self.wAPI parserUser];
    [tableView reloadData];
    myself=[[TakeMySelf alloc] init];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrUsers count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ViewControllerThred *vc;
    vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerThred"];
    vc.userTmp=[arrUsers objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    /*cvc=[self.storyboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
    cvc.userI=[arrUsers objectAtIndex:indexPath.row ];
    [self.navigationController pushViewController:cvc animated:YES];*/
    
}

-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *sIdentify=@"friends";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:sIdentify];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]
              initWithStyle:
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
@end
