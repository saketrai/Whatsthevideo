//
//  DCPlayerViewController.m
//  DumbCharade
//
//  Created by Santa on 1/22/13.
//
//

#import "DCPlayerViewController.h"
#import "DCXMLParser.h"
#import "DCVideo.h"
#import "Mixpanel.h"
#import "DCScoreViewController.h"
#import <Parse/Parse.h>



@interface DCPlayerViewController ()
-(void)initializeUI;
-(void)playVideo;
-(void)playNextVideo;
-(NSMutableArray*)getArrayOfRandomQuestionsFromArray:(NSMutableArray*)pArray;
@end

@implementation DCPlayerViewController

@synthesize m_pTitle;
@synthesize m_pVideoPlayercontroller;
@synthesize m_pPlayNextBtn;
@synthesize m_pScoreLabel;
@synthesize pressedButtontag;
@synthesize pressedButtonText;
@synthesize currentLabelIndex;
@synthesize pressedLabelButtontag;
@synthesize pressedLabelButtontext;
@synthesize labelStateBool;
@synthesize answerLength;
@synthesize sumLabelArray;
@synthesize inputAnswer;
@synthesize correctAnswer;
@synthesize m_pSelectedQuesArray;
@synthesize counter;
@synthesize runCount;
@synthesize totalQuestions;
@synthesize labelButtons;
@synthesize answer;
@synthesize inputButtons;
@synthesize labels;
@synthesize coins;
@synthesize dictAns;
@synthesize bonus;
#pragma mark - View

- (NSMutableArray *)labelStateBool {
    if (!labelStateBool)
        labelStateBool= [[NSMutableArray alloc] init];
    return labelStateBool;
}

- (NSMutableArray *)inputAnswer {
    if (!inputAnswer)
        inputAnswer= [[NSMutableArray alloc] init];
    return inputAnswer;
}

- (NSMutableDictionary *)dictAns {
    if (!dictAns)
        dictAns= [[NSMutableDictionary alloc] init];
    return dictAns;
}
- (NSMutableArray *)correctAnswer {
    if (!correctAnswer)
        correctAnswer= [[NSMutableArray alloc] init];
    return correctAnswer;
}

- (NSMutableArray *)labelButtons {
    if (!labelButtons)
        labelButtons= [[NSMutableArray alloc] init];
    return labelButtons;
}

- (NSMutableArray *)hintButtons {
    if (!_hintButtons)
        _hintButtons= [[NSMutableArray alloc] init];
    return _hintButtons;
}
- (NSMutableArray *)inputButtons {
    if (!inputButtons)
        inputButtons= [[NSMutableArray alloc] init];
    return inputButtons;
}
- (NSMutableArray *)labels {
    if (!labels)
        labels= [[NSMutableArray alloc] init];
    return labels;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializeUI];
}


//To initialize the UI and objects
-(void)initializeUI
{
    mCorrectAnswers = 0;
    //self.counter=1;
    
    PFQuery *query1= [PFUser query];
    
    [query1 whereKey:@"username" equalTo:[[PFUser currentUser]username]];
    
    [query1 getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){

        self.counter = [[object objectForKey:@"atQuestion"] integerValue];
        
        self.coins = [[object objectForKey:@"coins"] integerValue];
        self.runCount = [[object objectForKey:@"RunCount"] integerValue];
         self.bonus = [[object objectForKey:@"starterBonus"] integerValue];
        if (self.counter==0){
            self.counter=1;
        }
    
    if(self.counter==1 && self.runCount<1 && self.bonus==0)
    {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congrats! You have been awarded 1000 FREE coins."
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:
                          @"Thanks",
                          //@"800 coins",
                          // @"2000 coins",
                          //@"5000 coins",
                          nil];
    alert.tag = 3;
        PFUser *user = [PFUser currentUser];
        [user setObject:[NSNumber numberWithInt:1] forKey:@"starterBonus"];
       
        [user saveInBackground];
        

     
    
    [alert show];
    }
    }];
    
 

    //Get the question from XMl
    //NSString* filePath = [[NSBundle mainBundle] pathForResource:Videos ofType:@".xml"];
    //NSString *tempXml = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
   // NSData *data = [tempXml dataUsingEncoding:NSUTF8StringEncoding];
   // NSDictionary *tempDictionary = [DCXMLParser dictionaryForXMLData:data error:nil];
    //NSLog(@"XML Data is:%@",tempDictionary);
    //NSMutableArray *theQuestionsDataArray = [self getQuestionsArray:tempDictionary];
   
    
    //Select n random question from the questions list
    //Update not selecting randomly
    //self.m_pSelectedQuesArray = theQuestionsDataArray;
    //self.m_pSelectedQuesArray = [self getArrayOfRandomQuestionsFromArray:theQuestionsDataArray];
   // DLog(@"theSelectedQArray is %@", m_pSelectedQuesArray);
    //mSelectedQuestionIndex = 0;
   
   // NSString *theSoundPath = [[NSBundle mainBundle] pathForResource:@"Clock_Sound" ofType:@"mp3"];
    //NSURL *theSoundURL = [[NSURL alloc] initFileURLWithPath:theSoundPath];
    //Initialize the AVAudioPlayer.
    //self.m_pClockSoundPlayer = [[AVAudioPlayer alloc]
     //                           initWithContentsOfURL:theSoundURL error:nil];
    //self.m_pClockSoundPlayer.numberOfLoops = -1;//To play infinite
    [self playVideo];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoFinished:) name:@"MPMoviePlayerPlaybackDidFinishNotification" object:nil];
    //[self.m_pPlayNextBtn setEnabled:NO];
}



//To play the video and set value in options
-(void)playVideo
{
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.spinner.center = CGPointMake(160, 190);
    
    self.spinner.hidesWhenStopped = YES;
    

    
    //Getting the video from Parse database
    //PFUser *user = [PFUser currentUser];
    
    //NSLog(@"User is %@", user);
    
    self.Question.text = @"Q";
    [self.Question setFont:[UIFont fontWithName:@"Signika-Regular" size:18]];
    PFQuery *query1= [PFUser query];
    
    [query1 whereKey:@"username" equalTo:[[PFUser currentUser]username]];
    
    [query1 getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
        
        self.counter = [[object objectForKey:@"atQuestion"] integerValue];
        self.coins = [[object objectForKey:@"coins"] integerValue];
        if (self.counter==0){
            self.counter=1;
        }
        
        self.questionNumber.text=  [NSString stringWithFormat:@"%i", self.counter];
        [self.questionNumber setFont:[UIFont fontWithName:@"Signika-Regular" size:20]];
        //NSLog(@"counter is %d",[[object objectForKey:@"atQuestion"] integerValue]);
        [self.m_pScoreLabel setText:[NSString stringWithFormat:@"  %d",self.coins]];
        [self.m_pScoreLabel setFont:[UIFont fontWithName:@"Signika-Regular" size:18]];
        
        
        PFQuery *query = [PFQuery queryWithClassName:@"Video"];
        [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
            if (!error) {
                self.totalQuestions=count;
                [query whereKey:@"videoID" equalTo:[NSString stringWithFormat:@"%d",self.counter]];
                [query findObjectsInBackgroundWithBlock:^(NSArray* scoreArray, NSError *error) {
                    if (!error) {
                        // The get request succeeded. Log the score
                        //NSLog(@"success");
                        
                        
                        //PFQuery *query = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:fewWins,lotsOfWins,nil]];
                        
                        
                        // NSArray* scoreArray = [query findObjects];
                        
                        
                        
                        if (self.counter<count+1) {
                            //NSLog(@"query is :%@",[scoreArray[0] objectForKey:@"answer"]);
                            NSString* URL=[scoreArray[0] objectForKey:@"VideoURL"];
                            NSString* ans = [scoreArray[0] objectForKey:@"answer"];
                            NSString* title = [scoreArray[0] objectForKey:@"title"];
                            
                            
                            UIImageView *videoBackgroungImage = [[UIImageView alloc] initWithFrame:CGRectMake(8.0f, 50.0f, 304.0f, 240.0f)];
                            //create ImageView
                            
                            videoBackgroungImage.image = [UIImage imageNamed:@"Video_frame.png"];
                            [self.view addSubview:videoBackgroungImage];
                            
                            //mClockTime = 1;
                            //DCVideo *theVideo = [m_pSelectedQuesArray objectAtIndex:mSelectedQuestionIndex];
                            
                            //Using the movie player controller
                            NSString *theVideoURL = [NSString stringWithFormat:@"%@%@",YOUTUBE_URL, URL];
                            
                            
//                            NSString *m_pPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:(@"%@.mp4"), URL ]];
                            
//                            if ([[NSFileManager defaultManager] fileExistsAtPath:m_pPath])
//                            {
//                                [self.view addSubview:self.spinner];
//                                
//                                [self.spinner startAnimating];
//                                self.m_pVideoPlayercontroller = [[LBYouTubePlayerController alloc] initWithLocalYoutubeVideo:[NSMutableData dataWithContentsOfFile:m_pPath]];
//                            }
//                            else
//                            {
                                [self.view addSubview:self.spinner];
                                
                                [self.spinner startAnimating];
                                
                                self.m_pVideoPlayercontroller = [[LBYouTubePlayerViewController alloc] initWithYouTubeURL:[NSURL URLWithString:theVideoURL] quality:LBYouTubeVideoQualitySmall];
                            //}
                            self.m_pVideoPlayercontroller.delegate = self;
                            self.m_pVideoPlayercontroller.view.frame = CGRectMake(15.0f, 107.0f, 291.0f, 177.0f);
                            self.m_pVideoPlayercontroller.view.autoresizingMask =  UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
                            self.m_pVideoPlayercontroller.view.backgroundColor = [UIColor clearColor];
                            [self.view addSubview:self.m_pVideoPlayercontroller.view];
                            
                            //NSLog(@"Option1 is : %@",theVideo.m_pOption1);
                            m_pTitle.text = title;
                            [m_pTitle setFont:[UIFont fontWithName:@"Signika-Regular" size:22]];
                            
                            
                            self.labelButtons = [[NSMutableArray alloc] init];
                            
                            //Extracting the letters from the string
                            NSString * optChar = ans;
                            self.answer=ans;
                            self.answerLength=ans.length;
                            NSMutableArray *list = [NSMutableArray array];
                            for (int i=0; i<optChar.length; i++) {
                                [self.labelStateBool addObject:[NSNumber numberWithInt:0]];
                                [self.inputAnswer addObject:@"-"];
                                [list addObject:[optChar substringWithRange:NSMakeRange(i, 1)]];
                                // self.labelStateBool[i]=0;
                            }
                            
                            //self.ansDict = [NSMutableDictionary dictionary];
                            
                           
                            self.correctAnswer=[list copy];
                            
                            for (int i=0; i<self.answerLength; i++) {
                                
                                [self.dictAns setObject:[self.correctAnswer objectAtIndex:i] forKey:[NSNumber numberWithInt:i]];
                            }
                            //NSLog(@"The letters are%@", self.labelStateBool);
                            //NSLog(@"Label Button %@", self.labelButtons);
                            
                            //Creating another array with random alphabets and 12-word length
                            NSMutableArray *list2 = [NSMutableArray array];
                            for (int i=0; i<12-optChar.length; i++) {
                                
                                NSString* c = [NSString stringWithFormat:@"%c", arc4random_uniform(26) + 'A'];
                                [list2 addObject:c];
                            }
                            
                            
                            NSArray *list3=[list arrayByAddingObjectsFromArray:list2];
                            NSArray * list4 =[self shuffleArray:list3];
                            
                            
                            NSLog(@"Random array is %@", list4);
                            for (int i=0; i < 12; i++) {
                                
                                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                                [button setBackgroundImage:[UIImage imageNamed:@"Deep-Blue_@2x.png"]
                                                  forState:UIControlStateNormal];
                                [[button titleLabel] setFont:[UIFont fontWithName:@"Signika-Regular" size:20.0f]];
                                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                                button.backgroundColor = [UIColor clearColor];
                                
                                
                                
                                if(i<6)
                                {
                                    button.frame = CGRectMake((i*45)+10, 370, 35,35);
                                    
                                }
                                else
                                {
                                    button.frame = CGRectMake(((i-6)*45)+10, 415, 35,35);
                                }
                                [button setTitle:list4[i] forState:UIControlStateNormal];
                                button.tag=i;
                                [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                                [self.view addSubview:button];
                                [self.inputButtons addObject:button];
                                //[button setImage:[UIImage imageNamed:@"btn_highlighted.png"] forState:UIControlStateHighlighted];
                                //[button setImage:[UIImage imageNamed:@"btn_highlighted.png"] forState:UIControlStateSelected];
                                
                            }
                            for (int i=0; i < self.answerLength; i++)
                            {
                                
                                UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake((i*25)+10, 320, 20,20)];
                                myLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"white_@2x.png"]];
                                
                                //[myLabel setBackgroundColor:[UIColor clearColor]];
                                //[myLabel setText:@"Hi Label"];
                                [[self view] addSubview:myLabel];
                                [self.labels addObject:myLabel];
                            }
                            
                            
                            
                        }
                        
                    } else {
                        // Log details of our failure
                        //NSLog(@"Error: %@ %@", error, [error userInfo]);
                    }
                }];
                
            } else {
                // The request failed
            }
        }];
        
    }];

    
    [self displayHintButtons];
    
    
    
    //To track the event
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"Video Played"];
}


-(void)displayHintButtons
{
    self.hintButtons = [[NSMutableArray alloc] init];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"Blue_@2x.png"]
                      forState:UIControlStateNormal];
    [[button titleLabel] setFont:[UIFont fontWithName:@"Signika-Regular" size:20.0f]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];

    button.frame = CGRectMake((6*45)+10, 370, 35,35);
     [button setImage:[UIImage imageNamed:@"white_glass_to_activate"] forState:UIControlStateNormal];
    //[button setTitle:@"+" forState:UIControlStateNormal];
    button.tag=13;
    
    [self.hintButtons addObject:button];

   
   
   [button addTarget:self action:@selector(hintShowLetterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //[self.inputButtons addObject:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setBackgroundImage:[UIImage imageNamed:@"Orange_@2x.png"]
                      forState:UIControlStateNormal];
    [[button1 titleLabel] setFont:[UIFont fontWithName:@"Signika-Regular" size:18.0f]];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor clearColor];
    
    button1.frame = CGRectMake((5*45)+10, 11, 18,18);
   
    
    [button1 setTitle:@"$" forState:UIControlStateNormal];
    button1.tag=14;
    [self.hintButtons addObject:button1];
    
    [button1 addTarget:self action:@selector(coinPurchaseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    


}

-(void)coinPurchaseButtonPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase coins?"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:
                                                            @"300 coins       $0.99",
                                                            @"2000 coins      $4.99",
                                                            @"4500 coins      $9.99",
                                                            @"10000 coins     $19.99",
                                                            nil];
    alert.tag = 2;
    
    [alert show];
}

-(void)coinPurchaseButtonPressed
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not enough coins. Purchase?"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:
                          @"300 coins       $0.99",
                          @"2000 coins      $4.99",
                          @"4500 coins      $9.99",
                          @"10000 coins     $19.99",
                          nil];
    alert.tag = 2;
    
    [alert show];
}

-(void)hintShowLetterButtonPressed:(id)sender

{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Show a correct letter"
                                                    message:@"Costs you 100 coins"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Ok",nil];
    alert.tag = 1;

    [alert show];
    //alert.delegate=self;
   // NSMutableArray* answerArray=self.correctAnswer;
}

-(void)shareonfbbuttonpresses:(id)sender

{
    

}

-(void)processHintShowLetter
{
if (!([self.dictAns count] == 0))  
{
        // self.labelStateBool[i]=0;
    
    PFUser *user = [PFUser currentUser];
    //[user incrementKey:@"Score" byAmount:[NSNumber numberWithInt:2]];
    //[user setObject:[NSNumber numberWithInt:self.counter] forKey:@"atQuestion"];
    
    if (self.coins>=100)
    {
        
    
    [user incrementKey:@"coins" byAmount:[NSNumber numberWithInt:-100]];
    
    [user saveInBackground];
    self.coins=self.coins-100;
    
    [self.m_pScoreLabel setText:[NSString stringWithFormat:@"  %d",self.coins]];
    [self.m_pScoreLabel setFont:[UIFont fontWithName:@"Signika-Regular" size:18]];

    NSLog(@"Dictionary is %@",self.dictAns);
    
    //Generating a random character from the answer
    

    
    NSArray *array = [self.dictAns allKeys];
    int random = arc4random()%[array count];
    NSString *key = [array objectAtIndex:random];
    NSLog(@"Random is %@",[self.dictAns objectForKey:key]);
    NSString*  hintLetter= [self.dictAns objectForKey:key];
    [self.dictAns removeObjectForKey:key];
    //NSLog(@"Dictionary is %@",self.dictAns);
    self.pressedButtonText=hintLetter;//removing th bug
    
    NSLog(@"key is %@",key);
    

    
    for(UIButton* b in self.inputButtons)
    {
        if ([b.titleLabel.text isEqualToString:hintLetter])
        {
        
        //NSLog(@"Button text is %@",self.labelButtons);
        //b.titleLabel.textColor = [UIColor greenColor];
        //[b setBackgroundImage:[UIImage imageNamed:@"Orange_@2x@2x.png"]
        //             forState:UIControlStateNormal];
            self.pressedButtontag=b.tag;
            
            [b removeFromSuperview];
            [self.inputButtons removeObject:b];

           
            break;
        }
    }

    //UIButton* button=[self.inputButtons objectAtIndex:randomIndex];
    //[button sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    //Removing an existing button if present at the hint location
    NSArray* labelButtonCopy=[self.labelButtons copy];
    for(UIButton* b in labelButtonCopy)
    {
       
       //NSLog(@"Button is%@",b.titleLabel.text);
        if(b.state == UIControlStateNormal)
        {
        [b sendActionsForControlEvents:UIControlEventTouchUpInside];
        //[b removeFromSuperview];
        }

        
    }
        [self addToLabelAtPosition:[key integerValue]enableButton:NO];

    
    }
    else
    {
        [self coinPurchaseButtonPressed];
    }
    
}
    
    
}
-(void)buttonPressed:(id)sender toSendAtLabel:(int)k

{
   // NSLog(@"array is %@",self.labelStateBool);
    //NSLog(@"sum of array is %@",[self.labelStateBool valueForKeyPath:@"@sum.self"]);
    if ( [[self.labelStateBool valueForKeyPath:@"@sum.self"] integerValue]!=self.answerLength)
        {
            
            UIButton *button = (UIButton *)sender;

           // NSLog(@"Button Tag is%d", button.tag);
            //NSLog(@"%@", button.titleLabel.text);

            self.pressedButtonText=button.titleLabel.text;
            self.pressedButtontag=button.tag;
            [button removeFromSuperview];
            [self.inputButtons removeObject:button];
    
        }
    [self addToLabelAtPosition:0 enableButton:YES];
}


-(void)buttonPressed:(id)sender 

{
    // NSLog(@"array is %@",self.labelStateBool);
    //NSLog(@"sum of array is %@",[self.labelStateBool valueForKeyPath:@"@sum.self"]);
    if ( [[self.labelStateBool valueForKeyPath:@"@sum.self"] integerValue]!=self.answerLength)
    {
        
        UIButton *button = (UIButton *)sender;
        
       // NSLog(@"Button Tag is%d", button.tag);
        //NSLog(@"%@", button.titleLabel.text);
        
        self.pressedButtonText=button.titleLabel.text;
        self.pressedButtontag=button.tag;
        [button removeFromSuperview];
        [self.inputButtons removeObject:button];
        
    }
    //self.pressedButtonText ;
    [self addToLabelAtPosition:0 enableButton:YES];
}


-(void)labelButtonPressed:(id)sender
{

    UIButton *button = (UIButton *)sender;
    
    //NSLog(@"%d", button.tag);
    //NSLog(@"%@", button.titleLabel.text);
    [button removeFromSuperview];
    [self.labelButtons removeObject:button];
    //NSLog(@"Label Button %@", self.labelButtons);

    self.pressedLabelButtontag = button.tag;
    self.pressedLabelButtontext = button.titleLabel.text;
    int k=(button.frame.origin.x-10)/25;

    [self.labelStateBool replaceObjectAtIndex:k withObject:[NSNumber numberWithInt:0]];
    for(UIButton* b in self.labelButtons)
    {
        [b setBackgroundImage:[UIImage imageNamed:@"Magenta_@2x.png"]
                     forState:UIControlStateNormal];
       
        
        //NSLog(@"Button text is %@",self.labelButtons);
        //b.titleLabel.textColor = [UIColor darkGrayColor];
    }

    [self returnLabelToButton];

    
}

-(void)returnLabelToButton
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"Deep-Blue_@2x.png"]
                      forState:UIControlStateNormal];
    [[button titleLabel] setFont:[UIFont fontWithName:@"Signika-Regular" size:20.0f]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];

    int i=self.pressedLabelButtontag;
    if(i<6)
    {
        button.frame = CGRectMake((i*45)+10, 370, 35,35);
    }
    else
    {
        button.frame = CGRectMake(((i-6)*45)+10, 415, 35,35);
    }
    [button setTitle:self.pressedLabelButtontext forState:UIControlStateNormal];
    button.tag=self.pressedLabelButtontag;
    
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    [self.inputButtons addObject:button];

    
}

-(void)addToLabelAtPosition:(int)j enableButton:(BOOL)k
{
    
    
    for(int i=j;i< self.answerLength;i++)
    {
        if ([self.labelStateBool objectAtIndex:i]==[NSNumber numberWithInt:0])
        {
            UIButton *labelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [labelButton setBackgroundImage:[UIImage imageNamed:@"Magenta_@2x.png"]
                              forState:UIControlStateNormal];
            [[labelButton titleLabel] setFont:[UIFont fontWithName:@"Signika-Bold" size:20.0f]];
            [labelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            labelButton.backgroundColor = [UIColor clearColor];
            labelButton.frame = CGRectMake((i*25)+10, 320, 20,20);
            [labelButton setTitle:self.pressedButtonText forState:UIControlStateNormal];
            labelButton.tag=self.pressedButtontag;
            
            [labelButton addTarget:self action:@selector(labelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [labelButton setEnabled:k];

            [self.view addSubview:labelButton];
            [self.labelButtons addObject:labelButton];
            //NSLog(@"Label Button %@", self.labelButtons);
            [self.labelStateBool replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:1]];
            [self.inputAnswer replaceObjectAtIndex:i withObject:labelButton.titleLabel.text];
            //NSLog(@"Input Answer is%@",self.inputAnswer);
            //NSLog(@"Correct Answer is%@",self.correctAnswer);
            if ( [[self.labelStateBool valueForKeyPath:@"@sum.self"] integerValue]==self.answerLength)
                {
                    if([self.inputAnswer isEqualToArray:self.correctAnswer])
                        {
                           // NSLog(@"Answer is correct");
                            for(UIButton* b in self.labelButtons)
                            {
                                //NSLog(@"Button text is %@",self.labelButtons);
                                //b.titleLabel.textColor = [UIColor greenColor];
                                [b setBackgroundImage:[UIImage imageNamed:@"19_@2x.png"]
                                                       forState:UIControlStateNormal];
                            }
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Awesome! You Got It"
                                                                            message:self.answer
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"Play Next"
                                                                  otherButtonTitles:nil];
                            [alert show];
                            alert.delegate=self;
                            //[alert release];
                            mCorrectAnswers++;
                            
                            
                            self.counter++;
                            self.coins=self.coins+10;
                            
                            PFUser *user = [PFUser currentUser];
                            [user incrementKey:@"Score" byAmount:[NSNumber numberWithInt:10]];
                            [user setObject:[NSNumber numberWithInt:self.counter] forKey:@"atQuestion"];
                            [user incrementKey:@"coins" byAmount:[NSNumber numberWithInt:10]];
                            [user saveInBackground];
                            
                            

                        }
                    else
                        {
                           // NSLog(@"Answer is wrong");
                            for(UIButton* b in self.labelButtons)
                            {
                                //NSLog(@"Button text is %@",self.labelButtons);
                                //b.titleLabel.textColor = [UIColor redColor];
                                [b setBackgroundImage:[UIImage imageNamed:@"red_@2x.png"]
                                             forState:UIControlStateNormal];
                            }
                           
                        }
                }
         
            i= 100;
            //NSLog(@"array is %@",self.labelStateBool);
            //NSLog(@"sum of array is %@",[self.labelStateBool valueForKeyPath:@"@sum.self"]);

        }
        //self.currentLabelIndex++;
    }
    
}

- (NSArray*)shuffleArray:(NSArray*)array {
    
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:array];
    
    for(NSUInteger i = [array count]; i > 1; i--) {
        NSUInteger j = arc4random_uniform(i);
        [temp exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
    
    return [NSArray arrayWithArray:temp];
}
-(void)prepareForNextVideo
{
if(self.counter == self.totalQuestions+1)
{
    //[self.m_pVideoPlayercontroller pause];
    //[self.m_pVideoPlayercontroller stop];
    DCScoreViewController *theScoreViewController = [[DCScoreViewController alloc] initWithNibName:@"DCScoreViewController" bundle:nil];
    //theScoreViewController.mScore = SCORE_MULTIPLIER*mCorrectAnswers;
    [self.navigationController pushViewController:theScoreViewController animated:YES];
}
else
{

    for(UIButton* b in self.labelButtons)
    {
        //NSLog(@"Button text is %@",self.labelButtons);
        [b removeFromSuperview];
    }
    
    for(UIButton* b in self.inputButtons)
    {
        //NSLog(@"Button text is %@",self.labelButtons);
        [b removeFromSuperview];
    }
    
    for(UILabel* b in self.labels)
    {
        //NSLog(@"Button text is %@",self.labelButtons);
        [b removeFromSuperview];
    }
    
    for(UIButton* b in self.hintButtons)
    {
        //NSLog(@"Button text is %@",self.labelButtons);
        [b removeFromSuperview];
    }
    //Initializing the label state array
    self.labelStateBool= [[NSMutableArray alloc] init];
    self.inputAnswer= [[NSMutableArray alloc] init];
    self.labelStateBool= [[NSMutableArray alloc] init];
    self.inputAnswer= [[NSMutableArray alloc] init];
    self.dictAns= [[NSMutableDictionary alloc] init];
    self.correctAnswer= [[NSMutableArray alloc] init];
    self.labelButtons= [[NSMutableArray alloc] init];
    self.inputButtons= [[NSMutableArray alloc] init];
    self.labels= [[NSMutableArray alloc] init];
    self.hintButtons= [[NSMutableArray alloc] init];

    [self playNextVideo];
    
        
    
}
}
//To invalide previous things and reset all controls and play next video
-(void)playNextVideo
{
if (self.m_pVideoPlayercontroller)
{
    [self.m_pVideoPlayercontroller.view removeFromSuperview];
}

    //[self.m_pShowTimeTimer invalidate];
    //[self.m_pClockTimer invalidate];//Invalidate the timer
    //[self setOptionsToNormal];
    //[self.m_pPlayNextBtn setEnabled:NO];
    //Increase the index and play next video
    mSelectedQuestionIndex++;
    //mIsVideoAnswered = NO;
    [self playVideo];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
           //NSLog(@"Cancel was pressed");
        } else {
           //NSLog(@"Ok was pressed");
            [self processHintShowLetter];
        }
    }
    else if (alertView.tag == 2) {
            switch(buttonIndex) {
                case 0:
                     //NSLog(@"Cancel was pressed");
                    break;
                case 1:
                   // NSLog(@"Ok was pressed");
                    [self purchaseCoinsOption:300 forDollar:1 forProduct:@"com.WhatstheVideo_pcoins_0_99"];
                    break;
                case 2:
                    //NSLog(@"Ok2 was pressed");
                    [self purchaseCoinsOption:2000 forDollar:5 forProduct:@"com.WhatstheVideo_pcoins_4_99"];
                                        break;
                case 3:
                    //NSLog(@"Ok3 was pressed");
                    [self purchaseCoinsOption:4500 forDollar:10 forProduct:@"com.WhatstheVideo_pcoins_9_99"];
                                       break;
                case 4:
                    //NSLog(@"Ok4 was pressed");
                    [self purchaseCoinsOption:10000 forDollar:20 forProduct:@"com.WhatstheVideo_pcoins_19_99"];

                    break;
//                case 5:
//                    [self purchaseCoinsOption:100000 forDollar:99.99 forProduct:@"com.WhatstheVideo_pcoins_99_99"];
//                                        break;
                
                default:
                    break;
        }
    }
    
    else if (alertView.tag == 3) {
        switch(buttonIndex) {
            case 0:
                //NSLog(@"Cancel was pressed");
                break;
            case 1:
                // NSLog(@"Ok was pressed");
                [self purchaseCoinsOption:1000 forDollar:0.00];
               break;

            default:
                break;
        }
    }
    else {
        
    if (buttonIndex == 0) {
        [self.m_pScoreLabel setText:[NSString stringWithFormat:@"  %d",self.coins]];
        [self.m_pScoreLabel setFont:[UIFont fontWithName:@"Signika-Regular" size:18]];
        [self prepareForNextVideo];

    }
    }
}
-(void)purchaseCoinsOption:(int) i forDollar:(float)j forProduct:(NSString*)k
{
    
    [PFPurchase buyProduct:k block:^(NSError *error) {
        if (!error) {
            // Run UI logic that informs user the product has been purchased, such as displaying an alert view.
            self.coins=self.coins+i;
            
            
            PFUser *user = [PFUser currentUser];
            //[user incrementKey:@"Score" byAmount:[NSNumber numberWithInt:2]];
            //[user setObject:[NSNumber numberWithInt:self.counter] forKey:@"atQuestion"];
            [user incrementKey:@"coins" byAmount:[NSNumber numberWithInt:i]];
            [user incrementKey:@"dollarSpent" byAmount:[NSNumber numberWithInt:j]];
            [user saveInBackground];
            [self.m_pScoreLabel setText:[NSString stringWithFormat:@"  %d",self.coins]];
            [self.m_pScoreLabel setFont:[UIFont fontWithName:@"Signika-Regular" size:18]];
        }
    }];
    


}

-(void)purchaseCoinsOption:(int) i forDollar:(float)j 
{

            // Run UI logic that informs user the product has been purchased, such as displaying an alert view.
            self.coins=self.coins+i;
            
            
            PFUser *user = [PFUser currentUser];
            //[user incrementKey:@"Score" byAmount:[NSNumber numberWithInt:2]];
            //[user setObject:[NSNumber numberWithInt:self.counter] forKey:@"atQuestion"];
            [user incrementKey:@"coins" byAmount:[NSNumber numberWithInt:i]];
            [user incrementKey:@"dollarSpent" byAmount:[NSNumber numberWithInt:j]];
            [user saveInBackground];
            [self.m_pScoreLabel setText:[NSString stringWithFormat:@"  %d",self.coins]];
            [self.m_pScoreLabel setFont:[UIFont fontWithName:@"Signika-Regular" size:18]];

    
    
    
}

-(IBAction)playNextVideo:(id)sender
{
   
    if(mSelectedQuestionIndex == NUMBER_OF_QUESTIONS-1)
    {
        //[self.m_pVideoPlayercontroller pause];
        //[self.m_pVideoPlayercontroller stop];
        DCScoreViewController *theScoreViewController = [[DCScoreViewController alloc] initWithNibName:@"DCScoreViewController" bundle:nil];
        //theScoreViewController.mScore = SCORE_MULTIPLIER*mCorrectAnswers;
        [self.navigationController pushViewController:theScoreViewController animated:YES];
    }
    else
    {
        [self playNextVideo];  
    }
}

- (IBAction)homeButtonPressed:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Misc

//To create the Array of Videos with the parsed data
-(NSMutableArray*)getQuestionsArray:(NSDictionary*)pDict
{
    NSMutableArray *theDataArray = [[NSMutableArray alloc] init];
    NSArray *theUserArray = [[pDict objectForKey:Videos] objectForKey:Video];
    for (NSDictionary *theDict in theUserArray)
    {
        DCVideo *theVideo = [[DCVideo alloc] init];
        theVideo.m_pVideoID = [[theDict objectForKey:VideoID] objectForKey:TEXT];
        theVideo.m_pVideoURL = [[theDict objectForKey:VideoURL] objectForKey:TEXT];
        theVideo.m_pVideoDuration = [[theDict objectForKey:VideoDuration] objectForKey:TEXT];
        theVideo.m_pVideoTitle = [[theDict objectForKey:VideoTitle] objectForKey:TEXT];
        theVideo.m_pOption1 = [[theDict objectForKey:Option1] objectForKey:TEXT];
        theVideo.m_pOption2 = [[theDict objectForKey:Option2] objectForKey:TEXT];
        theVideo.m_pOption3 = [[theDict objectForKey:Option3] objectForKey:TEXT];
        theVideo.m_pOption4 = [[theDict objectForKey:Option4] objectForKey:TEXT];
        theVideo.m_pAns = [[theDict objectForKey:Ans] objectForKey:TEXT];
        [theDataArray  addObject:theVideo];
    }
    return theDataArray;
}


//Takes an array of all the videos and returns an array of some(Defined number) videos randomly
-(NSMutableArray*)getArrayOfRandomQuestionsFromArray:(NSMutableArray*)pArray
{
    NSMutableArray* theSelectedQues = [[NSMutableArray alloc] init];
    NSInteger numberOfQuestion = NUMBER_OF_QUESTIONS;
    if ( [pArray count] >= numberOfQuestion)
    {
        while (numberOfQuestion > 0)
        {
            NSDictionary *theQuestion = [pArray objectAtIndex: arc4random() % [pArray count]];
            
            if (![theSelectedQues containsObject: theQuestion])
            {
                [theSelectedQues addObject: theQuestion];
                numberOfQuestion --;
            }
        }
    }
    return theSelectedQues;
}

#pragma mark - LBYouTubePlayerViewControllerDelegate

-(void)youTubePlayerViewController:(LBYouTubePlayerViewController *)controller didSuccessfullyExtractYouTubeURL:(NSURL *)videoURL {
    DLog(@"Did extract video source:%@", videoURL);
    [self.spinner stopAnimating];

}

-(void)youTubePlayerViewController:(LBYouTubePlayerViewController *)controller failedExtractingYouTubeURLWithError:(NSError *)error {
    DLog(@"Failed loading video due to error:%@", error);
}

//Called when the video is over//Start the timer for user.
- (void)videoFinished:(id)sender
{
    //DLog(@"videoFinished");
    
    // Start the timer and updating the stop watch only when the video is finished and not answered// If video is answered before the video finished, need not to show the timer.
    //if (mIsVideoAnswered == NO)
//    //{
//        self.m_pShowTimeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
//                                                                 target:self
//                                                               selector:@selector(showTime)
//                                                               userInfo:nil
//                                                                repeats:YES];
//        [self startClockTimer];
//    }
    
}

    


@end
