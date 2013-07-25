//
//  DCPlayerViewController.h
//  DumbCharade
//
//  Created by Santa on 1/22/13.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "LBYouTube.h"
#import <Parse/Parse.h>


@interface DCPlayerViewController : UIViewController<LBYouTubePlayerControllerDelegate, UIAlertViewDelegate>
{
    
    IBOutlet UILabel    *m_pTitle;
    IBOutlet UILabel    *m_pScoreLabel;
    NSInteger           mSelectedQuestionIndex;
    NSMutableArray      *m_pSelectedQuesArray;

    LBYouTubePlayerViewController   *m_pVideoPlayercontroller;
    IBOutlet UIButton           *m_pPlayNextBtn;
    NSInteger                   mCorrectAnswers;


}
@property(strong, nonatomic)IBOutlet UILabel    *m_pTitle;
@property(strong, nonatomic)IBOutlet UILabel    *m_pScoreLabel;
@property(strong, nonatomic)NSMutableArray      *m_pSelectedQuesArray;
@property (nonatomic, strong) LBYouTubePlayerViewController *m_pVideoPlayercontroller;
@property(strong, nonatomic)IBOutlet UIButton           *m_pPlayNextBtn;
@property(strong,nonatomic) NSString* pressedButtonText;
@property(nonatomic) int pressedButtontag;
@property(nonatomic) int currentLabelIndex;

@property(nonatomic) int pressedLabelButtontag;
@property(strong,nonatomic) NSString*pressedLabelButtontext;
@property(strong,nonatomic) NSMutableArray * labelStateBool;
@property(nonatomic) int answerLength;
@property(strong,nonatomic)NSNumber*sumLabelArray;
@property(strong,nonatomic) NSMutableArray * inputAnswer;
@property(strong,nonatomic) NSMutableArray * correctAnswer;
@property(strong,nonatomic) NSMutableArray * labelButtons;
@property(strong,nonatomic) NSMutableArray * inputButtons;
@property(strong,nonatomic) NSMutableArray * labels;
@property(nonatomic) int counter;
@property(nonatomic) BOOL bonus;
@property(nonatomic) int runCount;
@property(nonatomic) int totalQuestions;
@property(strong,nonatomic) NSString* answer;
@property(nonatomic) int coins;
@property(strong,nonatomic) NSMutableDictionary* dictAns;
@property (strong, nonatomic) UIActivityIndicatorView* spinner;
@property(strong,nonatomic) NSMutableArray * hintButtons;
@property (strong, nonatomic) IBOutlet UILabel *Question;
@property (strong, nonatomic) IBOutlet UILabel *questionNumber;

-(IBAction)playNextVideo:(id)sender;
- (IBAction)homeButtonPressed:(UIButton *)sender;
@end
