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
TakeMySelf*  myself;
User* sendUser;
UITableView *tableView;
NSArray *arrUsers;
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
    sendUser=[arrUsers objectAtIndex:indexPath.row];
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"What do you choose...?"
                                                       message:sendUser.fullName
                                                      delegate:self
                                             cancelButtonTitle:@"Message"
                                             otherButtonTitles:@"Show Photos", nil];
    [theAlert show];
    
    //ViewControllerThred *vc;
    //vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerThred"];
    //vc.userTmp=[arrUsers objectAtIndex:indexPath.row];
    //vc.my=myself;
    //[self.navigationController pushViewController:vc animated:YES];
    /*CollectionViewController *cvc;
    cvc=[self.storyboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
    cvc.userI=[arrUsers objectAtIndex:indexPath.row ];
    [self.navigationController pushViewController:cvc animated:YES];*/
    
}
- (void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[theAlert buttonTitleAtIndex:buttonIndex] isEqual:@"Message"]) {
        ViewControllerThred *vc;
        vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerThred"];
        vc.userTmp=sendUser;
        vc.mySelf=myself;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        CollectionViewController *cvc;
        cvc=[self.storyboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
        cvc.userI=sendUser;
        [self.navigationController pushViewController:cvc animated:YES];
    }
    NSLog(@"%@ ", [theAlert buttonTitleAtIndex:buttonIndex]);
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
            cell.imageView.clipsToBounds=YES;
            cell.imageView.layer.cornerRadius=cell.imageView.frame.size.width/2;
        });
    });
    return cell;
}
@end
