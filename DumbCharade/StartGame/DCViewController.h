//
//  DCViewController.h
//  DumbCharade
//
//  Created by Santa on 1/22/13.
//
//

#import <UIKit/UIKit.h>

@interface DCViewController : UIViewController
{
    IBOutlet UITextView     *m_pTextView;
}

@property (strong, nonatomic) IBOutlet UILabel *instructions;

@property (strong, nonatomic) IBOutlet UILabel *appTitle;


-(IBAction)startPlayingBtnPressed:(id)sender;
@end
