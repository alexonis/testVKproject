//
//  MyCustomCell.m
//  testVKproject
//
//  Created by Alexonis on 09.01.16.
//  Copyright © 2016 Alexonis. All rights reserved.
//

#import "MyCustomCell.h"
int tagImageView=909;
@implementation MyCustomCell
NSMutableArray* arrayImgView;
UILabel* labelName;
- (void)awakeFromNib {

}


-(id) createCell:(Messages *)mesI
{
    int x=75;
    if ([mesI.arrayOfImages count]>0) {
    for (UIImage *img in mesI.arrayOfImages) {
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(x,0, 260,260)];
        imgView.tag=tagImageView;
        [self.contentView addSubview:imgView];
        imgView.image=img;
        x+=130;
        }
    }
    else
    {
        [[self viewWithTag:tagImageView] removeFromSuperview];
    }
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
