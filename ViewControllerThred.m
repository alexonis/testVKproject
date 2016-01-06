//
//  ViewControllerThred.m
//  testVKproject
//
//  Created by Alexonis on 04.01.16.
//  Copyright © 2016 Alexonis. All rights reserved.
//

#import "ViewControllerThred.h"
#import "WorkAPI.h"
@interface ViewControllerThred ()

@end
const int tagTbl=333;
const int tagTxf=666;
const int tagBtn=999;
NSString *tmpStr;

@implementation ViewControllerThred
-(void) requestMesg
{
    [self.userTmp getMessage];
}
-(void) downloadMsg
{
    [historyMessage removeAllObjects];
    [historyMessage addObjectsFromArray:self.userTmp.msgHist];
    [tableView reloadData];
    CGPoint bottomOffset = CGPointMake(0, tableView.contentSize.height - tableView.bounds.size.height);
    [tableView setContentOffset:bottomOffset animated:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadMsg)
                                                 name:@"MyNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(requestMesg)
                                                 name:@"SendComplite"
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
    interPhoto=self.userTmp->avaImg;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) btnSend
{

    NSCharacterSet* charetSet=[NSCharacterSet characterSetWithCharactersInString:@" "];
    NSString* resultStr= (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)textMsg.text,NULL,NULL,kCFStringEncodingUTF8));
    resultStr=[[resultStr componentsSeparatedByCharactersInSet:charetSet]
                       componentsJoinedByString:@"+"];
    [self.userTmp sendMsg:resultStr];
    textMsg.text=nil;
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [historyMessage count];
}
-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *cellIdentifier=@"Message";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]
              initWithStyle:
              UITableViewCellStyleDefault
              reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text =[historyMessage [[historyMessage count]-indexPath.row-1] substringToIndex:[historyMessage[[historyMessage count]-indexPath.row-1]length]-1];
    tmpStr=[historyMessage[[historyMessage count]-indexPath.row-1] substringFromIndex:[historyMessage[[historyMessage count]-indexPath.row-1]length]-1];
    if ([tmpStr isEqual:@"0"]) {
        
        cell.imageView.image=interPhoto;
        
    }
    else
    {
        cell.imageView.image=myPhoto;
    }

    return cell;

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
