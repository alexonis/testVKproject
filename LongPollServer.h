//
//  LongPollServer.h
//  testVKproject
//
//  Created by Alexonis on 28.01.16.
//  Copyright © 2016 Alexonis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LongPollServer : NSObject<NSURLConnectionDelegate>
-(LongPollServer*) init;
-(void)connectToLongPoll;
-(void)listeningLongPollServer;
-(void)parserMessageFromLongPoll;
@end
