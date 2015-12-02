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
NSMutableArray *arraF;
@implementation ViewControllerSecond
-(NSMutableArray*) parser:(NSArray*) array
{
    NSMutableArray *arFin=[NSMutableArray arrayWithCapacity:[array count]];;
    NSString *strF;
    for( NSDictionary *friend in array)
    {
        strF=[NSString stringWithFormat:@"%@ %@",
              [friend objectForKey:@"first_name"],
              [friend objectForKey:@"last_name"]];
        [arFin addObject:strF];
    }
    return arFin;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayItems count];
}

-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *sIdentify=@"friends";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:sIdentify];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:
              UITableViewCellStyleDefault
                                    reuseIdentifier:sIdentify];
    }
    cell.textLabel.text=[arraF objectAtIndex:indexPath.row];
    return cell;
}

- (void)viewDidLoad {
    self.title=@"Friends";
    tableView.delegate=self;
    tableView.dataSource=self;
    arraF=[self parser:self.arrayItems];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
