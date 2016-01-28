//
//  MyCustomCell.h
//  testVKproject
//
//  Created by Alexonis on 09.01.16.
//  Copyright © 2016 Alexonis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Messages.h"
@interface MyCustomCell : UITableViewCell
@property UILabel* labelMessage;
@property UIImageView* imageViewAvatar;
-(id) createCell:(Messages*) mesI;
-(id)initWithMessage:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
