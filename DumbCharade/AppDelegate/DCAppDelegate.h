//
//  DCAppDelegate.h
//  DumbCharade
//
//  Created by Santa on 1/22/13.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class DCViewController;
@class Mixpanel;

@interface DCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) DCViewController *viewController;

@property (strong, nonatomic) UINavigationController    *m_pNavController;

@property (strong, nonatomic) Mixpanel *mixpanel;

@end
