//
//  DCAppDelegate.m
//  DumbCharade
//
//  Created by Santa on 1/22/13.
//
//

#import "DCAppDelegate.h"
#import "DCViewController.h"
#import "Mixpanel.h"
#import <Parse/Parse.h>
#import "LBYouTube.h"
#import <FacebookSDK/FacebookSDK.h>


@interface DCAppDelegate ()
-(void)downloadVideosAndSaveInDocuments;
@end

@implementation DCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //Parse
    [Parse setApplicationId:@"C71LxoYplsIgGjwTCrYLsHuYLYPpO7amKLJ9xMjN" //change this
                  clientKey:@"vQJnn3K2OkGgkOXCrJNu03Vu3vncrgWkexSeipdJ"];//change this
    //PFUser *user = [PFUser currentUser];
    [PFUser enableAutomaticUser];
    [[PFUser currentUser] incrementKey:@"RunCount"];
    [[PFUser currentUser] saveInBackground];
    
    NSLog(@"User is %@", [PFUser currentUser]);
   // [PFUser logOut];
    
    //[PFUser removeObject:@"NW6XFsBo1N" forKey:@"objectId"];
    
    //NSLog(@"User is %@", [PFUser currentUser]);
    
    [PFPurchase addObserverForProduct:@"com.WhatstheVideo_pcoins_0_99" block:^(SKPaymentTransaction *transaction) {
        //isPro = YES;
    }];
//    [PFPurchase addObserverForProduct:@"com.WhatstheVideo_pcoins_1_99" block:^(SKPaymentTransaction *transaction) {
//        //isPro = YES;
//    }];
    [PFPurchase addObserverForProduct:@"com.WhatstheVideo_pcoins_4_99" block:^(SKPaymentTransaction *transaction) {
        //isPro = YES;
    }];
    [PFPurchase addObserverForProduct:@"com.WhatstheVideo_pcoins_9_99" block:^(SKPaymentTransaction *transaction) {
        //isPro = YES;
    }];
//    [PFPurchase addObserverForProduct:@"com.WhatstheVideo_pcoins_99_99" block:^(SKPaymentTransaction *transaction) {
//        //isPro = YES;
//    }];
    
    [PFPurchase addObserverForProduct:@"com.WhatstheVideo_pcoins_19_99" block:^(SKPaymentTransaction *transaction) {
        //isPro = YES;
    }];
    
    // Initialize the MixpanelAPI object
    self.mixpanel = [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];
    
    // Set the upload interval to 20 seconds for demonstration purposes. This would be overkill for most applications.
    self.mixpanel.flushInterval = 20; // defaults to 60 seconds
    self.mixpanel.distinctId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    //NSLog(@"ID:",self.mixpanel.distinctId );
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    self.viewController = [[DCViewController alloc] initWithNibName:@"DCViewController_iPhone" bundle:nil];
    //} else {
    //   self.viewController = [[DCViewController alloc] initWithNibName:@"DCViewController_iPad" bundle:nil];
    // }
    //[self downloadVideosAndSaveInDocuments];
    self.m_pNavController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = self.m_pNavController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)downloadVideosAndSaveInDocuments
{
    PFQuery *query = [PFQuery queryWithClassName:@"Video"];
    [query findObjectsInBackgroundWithBlock:^(NSArray* videoObjectArray, NSError *error) {
        if (!error) {
            NSArray *theDataArray = [[NSArray alloc] initWithArray:videoObjectArray];
            NSLog(@"theDataArray is%@", theDataArray);

            for (id object in theDataArray)
            {
                LBYouTubeExtractor *extractor = [[LBYouTubeExtractor alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:(@"%@%@"),YOUTUBE_URL, [object objectForKey:@"VideoURL"]]] quality:LBYouTubeVideoQualityLarge];
                NSString *pathToDocs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                
                NSString *filename = [NSString stringWithFormat:(@"%@.mp4"), [object objectForKey:@"VideoURL"]];
                NSString *m_pPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:filename];
                if (![[NSFileManager defaultManager] fileExistsAtPath:m_pPath])
                {
                    
                    [extractor extractVideoURLWithCompletionBlock:^(NSMutableData *videoURL, NSError *error) {
                        if(!error) {
                            NSLog(@"Did extract video URL using completion block: %@", videoURL);
                            
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                [videoURL writeToFile:[pathToDocs stringByAppendingPathComponent:filename] atomically:YES];
                                NSLog(@"File %@ successfully saved", filename);
                            });
                        } else {
                            NSLog(@"Failed extracting video URL using block due to error:%@", error);
                        }
                    }];
                }
            }

        }
    }];
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBSettings publishInstall:@"258770770934905"];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
