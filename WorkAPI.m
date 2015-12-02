//
//  WorkAPI.m
//  testVKproject
//
//  Created by Alexonis on 02.12.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import "WorkAPI.h"

@implementation WorkAPI

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
@end
