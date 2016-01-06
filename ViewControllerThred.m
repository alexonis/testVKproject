//
//  ViewControllerThred.m
//  testVKproject
//
//  Created by Alexonis on 04.01.16.
//  Copyright © 2016 Alexonis. All rights reserved.
//

#import "ViewControllerThred.h"

@interface ViewControllerThred ()

@end
const int tagTbl=333;
const int tagTxf=666;
const int tagBtn=999;
@implementation ViewControllerThred
-(void) downloadMsg
{
    NSLog(@"%@", @"Aloha");
    [historyMessage addObjectsFromArray:self.userTmp.msgHist];
    NSLog(@"%lu", [self.userTmp.msgHist count]);
    [tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadMsg)
                                                 name:@"MyNotification"
                                               object:nil];
    historyMessage=[[NSMutableArray alloc] init];
    [self.userTmp getMessage];
    self.title=self.userTmp.fullName;
    tableView=[[UITableView alloc] initWithFrame:
               CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50)];
    [self.view addSubview:tableView];
    textMsg=[[UITextField alloc] initWithFrame:CGRectMake(10, tableView.frame.size.height, 320, 40)];
    textMsg.tag=tagTxf;
    [self.view addSubview:textMsg];
    sendBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendBtn.tag=tagBtn;
    [sendBtn setTitle:@"Send Message" forState:UIControlStateNormal];
    [sendBtn sizeToFit];
    sendBtn.center = CGPointMake(350,tableView.frame.size.height+20);
    [sendBtn addTarget:self action:@selector(btnSend) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    tableView.tag=tagTbl;
    tableView.delegate=self;
    tableView.dataSource=self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu", [historyMessage count]);
    return [historyMessage count];
}
-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"%@",@"111");
    NSString *cellIdentifier=@"Message";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]
              initWithStyle:
              UITableViewCellStyleDefault
              reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text =historyMessage [[historyMessage count]-indexPath.row-1];
    
    return cell;

}
-(void) btnSend
{
    [self.userTmp sendMsg:textMsg.text];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
