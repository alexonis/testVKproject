//
//  ViewController.h
//  testVKproject
//
//  Created by Alexonis on 20.11.15.
//  Copyright © 2015 Alexonis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate>
{
    NSString* access_token;
    NSString* user_Id;
    UIWebView* webView;
    NSMutableData* dataVK;
}
-(IBAction)connectVK:(id)sender;
-(IBAction)GetFriends:(id)sender;
@end
