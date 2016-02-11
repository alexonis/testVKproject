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
#import "ViewController.h"
@interface ViewControllerSecond ()
@end
const static int tagTbl=666;
TakeMySelf*  myself;
User* sendUser;
UITableView *tableView;
NSArray *arrUsers;
@implementation ViewControllerSecond
- (void)viewDidLoad {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(([userDefaults objectForKey:@"token"]==nil)&&([userDefaults objectForKey:@"myId"]==nil))
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle:nil];
        ViewController *add =[storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        [self presentViewController:add animated:YES completion:NULL];//показать вьюшку поверх текущей
        self.wAPI=add.wAPI;
    }
    else{
       self.wAPI=[WorkAPI singleton];
    }
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
    UIWindow *alertWindow;
    alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertWindow.rootViewController = [UIViewController new];
    alertWindow.windowLevel = 10000001;
    alertWindow.hidden = NO;
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"What do you choose...?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        alertWindow.hidden = YES;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Message" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ViewControllerThred *vc;
        vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerThred"];
        vc.userTmp=sendUser;
        vc.mySelf=myself;
        [self.navigationController pushViewController:vc animated:YES];
        alertWindow.hidden = YES;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Show Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CollectionViewController *cvc;
        cvc=[self.storyboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
        cvc.userI=sendUser;
        [self.navigationController pushViewController:cvc animated:YES];
        alertWindow.hidden = YES;
    }]];
    [alertWindow.rootViewController presentViewController:alert animated:YES completion:nil];  
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
    if (user->avaImage!=nil) {
        cell.imageView.image=user->avaImage;
        cell.imageView.clipsToBounds=YES;
        cell.imageView.layer.cornerRadius=cell.imageView.frame.size.width/2;
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"notavatar.jpeg"];// Показываем заглушку если нет основной фотографии
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // Загрузка в другом потоке
            [arrUsers[indexPath.row] avaDownload];
            dispatch_async(dispatch_get_main_queue(), ^{ //Показываем фотографию в основном потоке
                cell.imageView.image=user->avaImage;
                cell.imageView.clipsToBounds=YES;
                cell.imageView.layer.cornerRadius=cell.imageView.frame.size.width/2;
            });
        });
    }
    return cell;
}
@end
