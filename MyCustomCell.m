//
//  MyCustomCell.m
//  testVKproject
//
//  Created by Alexonis on 09.01.16.
//  Copyright © 2016 Alexonis. All rights reserved.
//

#import "MyCustomCell.h"

@implementation MyCustomCell

- (void)awakeFromNib {

    // Initialization code
}

/*- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.imageViewAvatar=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, 40, 40)];
        [self addSubview:self.imageViewAvatar];
        self.labelMessage = [[UILabel alloc] initWithFrame:CGRectMake(44, 0, self.frame.size.width, self.frame.size.height)];
        NSLog(@"%f !", self.frame.size.width);
        self.labelMessage.textColor = [UIColor blackColor];
        [self.labelMessage setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.labelMessage addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[label]-(10)-|" options:0 metrics:nil views:@{@"label":self.labelMessage}]];
        self.labelMessage.backgroundColor=[UIColor purpleColor];
        //self.labelMessage.numberOfLines=0;
       // self.labelMessage.font = [UIFont fontWithName:@"AppleGothic" size:18.0f];
        [self addSubview:self.labelMessage];
        //+++++++++++++++++++++++++++++++++++++++++++++++++++++++
        //self.frame=CGRectMake(0, 0, 500, self.frame.size.height);//(20, 0, self.frame.size.width, self.frame.size.height)
    }
    return self;
}*/
-(id) createCell:(Messages *)mesI
{
    int x=50;
    for (UIImage *img in mesI.arrayOfImages) {
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(x,self.textLabel.frame.size.height, self.frame.size.height,self.frame.size.height)];
        [self addSubview:imgView];
        imgView.image=img;
        x+=50;
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
