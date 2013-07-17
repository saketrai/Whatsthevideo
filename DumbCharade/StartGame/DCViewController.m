//
//  DCViewController.m
//  DumbCharade
//
//  Created by Santa on 1/22/13.
//
//

#import "DCViewController.h"
#import "DCPlayerViewController.h"
#import <Parse/Parse.h>

@interface DCViewController ()
-(void)initializeUI;
@end

@implementation DCViewController
@synthesize appTitle;
@synthesize instructions;
#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden = YES;
    
    //test parse object
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    [testObject setObject:@"bar1" forKey:@"foo1"];
//    [testObject save];
    
    [self initializeUI];
}

-(void)initializeUI
{
    self.appTitle.text = @"WHAT'S THE VIDEO ?";
    [self.appTitle setFont:[UIFont fontWithName:@"Signika-Regular" size:30]];
    [self.instructions setFont:[UIFont fontWithName:@"Signika-Regular" size:20]];

    //NSString *myNewLineStr = @"\n";
    self.instructions.text  = INSTRUCTIONS;
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

-(IBAction)startPlayingBtnPressed:(id)sender
{
    DCPlayerViewController *theDCPlayerViewController = [[DCPlayerViewController alloc] initWithNibName:@"DCPlayerViewController" bundle:nil];
    [self.navigationController pushViewController:theDCPlayerViewController animated:YES];
}

@end
