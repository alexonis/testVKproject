//
//  ViewControllerThred.m
//  testVKproject
//
//  Created by Alexonis on 04.01.16.
//  Copyright © 2016 Alexonis. All rights reserved.
//

#import "ViewControllerThred.h"
#import "WorkAPI.h"
#import "Messages.h"
#import "MyCustomCell.h"
@interface ViewControllerThred ()

@end
const int tagTbl=333;
const int tagTxf=666;
const int tagBtn=999;

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
                                                 name:@"GetHistoryComplete"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(requestMesg)
                                                 name:@"SendComplete"
                                               object:nil];
    historyMessage=[[NSMutableArray alloc] init];
    [self.userTmp getMessage];
    self.title=self.userTmp.fullName;
    tableView=[[UITableView alloc] initWithFrame:
               CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50)];
    tableView.tag=tagTbl;
    tableView.delegate=self;
    tableView.dataSource=self;
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
    interPhoto=self.userTmp->avaImg;
    myPhoto=self.my->myImage;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
    historyMessage=[[historyMessage reverseObjectEnumerator] allObjects];
    return [historyMessage count];
}
-(MyCustomCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    Messages* strTmp=[Messages alloc];
    strTmp=historyMessage[indexPath.row];
    [strTmp TakeAttachementImg];
    if ([strTmp.mainString isEqual:@""]) {
        strTmp.mainString=@"Attachment";
    }
    NSString *cellIdentifier=@"Message";
    MyCustomCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil)
    {
        cell=[[MyCustomCell alloc]
              initWithStyle:
              UITableViewCellStyleDefault
              reuseIdentifier:cellIdentifier];
    }
    [cell createCell:strTmp];
    //cell.labelMessage.text=strTmp.mainString;
    //cell.labelMessage.numberOfLines=0;
    //[cell.labelMessage sizeToFit];
    cell.textLabel.text =strTmp.mainString;
    cell.textLabel.numberOfLines=0;
    [cell.textLabel sizeToFit];
   // cell.textLabel.backgroundColor=[UIColor blueColor];
    if ([strTmp.outString isEqual:@"0"]) {
        
        cell.imageView.image=interPhoto;
    }
    else
    {
        cell.imageView.image=myPhoto;
    }
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Messages *strTmp=[Messages alloc];
    strTmp= historyMessage [[historyMessage count]-indexPath.row-1];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, 40)];
    label.numberOfLines=0;
    label.text=strTmp.mainString;
    [label sizeToFit];
   // if (label.frame.size.height >= 40.0)
   // {
        //NSLog(@"%f",label.frame.size.height);
 //       return label.frame.size.height;
 //   }
  //  else
  //  {
        return 200.0;
  //  }
    
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
