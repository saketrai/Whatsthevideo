//
//  DCScoreViewController.m
//  DumbCharade
//
//  Created by Santa on 2/10/13.
//
//

#import "DCScoreViewController.h"

@interface DCScoreViewController ()

@end

@implementation DCScoreViewController
@synthesize message;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.message setText:@"Congratulations ! You have completed all the questions.  Stay tuned for more clues."];
    [self.message setFont:[UIFont fontWithName:@"Signika-Regular" size:25]];

    //[self.m_pCorrectAnsLbl setText:[NSString stringWithFormat:@"%d",mScore/SCORE_MULTIPLIER]];
    //[self.m_pInCorrectAnsLbl setText:[NSString stringWithFormat:@"%d",NUMBER_OF_QUESTIONS - (mScore/SCORE_MULTIPLIER)]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

-(IBAction)playAgainButtonPressed:(id)sender
{
    PFUser *user = [PFUser currentUser];
    //[user incrementKey:@"Score" byAmount:[NSNumber numberWithInt:2]];
    [user setObject:[NSNumber numberWithInt:1] forKey:@"atQuestion"];
    [user saveInBackground];
    [self. navigationController popToRootViewControllerAnimated:YES];
}

@end
