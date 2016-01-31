//
//  LongPollServer.h
//  testVKproject
//
//  Created by Alexonis on 28.01.16.
//  Copyright © 2016 Alexonis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Messages.h"
@interface LongPollServer : NSObject<NSURLConnectionDelegate>
+(LongPollServer *)singleton;
-(Messages*)giveMessage;
-(void)whoListening: (NSString*) userID;
-(void)connectToLongPoll;
-(void)listeningLongPollServer;
-(void)parserMessageFromLongPoll;
@end
