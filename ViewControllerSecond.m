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

@implementation ViewControllerSecond

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.ArrayItems count];
}

-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *SIdentify=@"friends";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:SIdentify];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:
              UITableViewCellStyleDefault
                                    reuseIdentifier:SIdentify];
    }
    NSDictionary *friend;
    friend= self.ArrayItems[indexPath.row];
    NSString *urlS=[friend objectForKey:@"photo_50"];
    NSURL *url=[NSURL URLWithString:urlS];
    NSData *dataIm= [NSData dataWithContentsOfURL:url];
    UIImage *imageU=[UIImage imageWithData:dataIm];
    NSString *strF=[NSString stringWithFormat:@"%@ %@ %@",
                    [friend objectForKey:@"first_name"],
                    [friend objectForKey:@"last_name"],
                    [friend objectForKey:@"online"]];
    NSCharacterSet *ch=[NSCharacterSet characterSetWithCharactersInString:@"1"];
    NSCharacterSet *ch1=[NSCharacterSet characterSetWithCharactersInString:@"0"];
    strF=[[strF componentsSeparatedByCharactersInSet:ch] componentsJoinedByString:@"●"];
    strF=[[strF componentsSeparatedByCharactersInSet:ch1] componentsJoinedByString:@""];
    cell.textLabel.text=strF;
    cell.imageView.image=imageU;
    return cell;


}

- (void)viewDidLoad {
    self.title=@"Friends";
    tableView.delegate=self;
    tableView.dataSource=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}
@end
