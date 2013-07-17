//
//  DCScoreViewController.h
//  DumbCharade
//
//  Created by Santa on 2/10/13.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DCScoreViewController : UIViewController

//@property(nonatomic, assign) NSInteger mScore;
@property(nonatomic, strong) IBOutlet UILabel *message;
//@property(nonatomic, strong) IBOutlet UILabel *m_pInCorrectAnsLbl;
//@property(nonatomic, strong) IBOutlet UILabel *m_pScoreLbl;

-(IBAction)playAgainButtonPressed:(id)sender;
@end
