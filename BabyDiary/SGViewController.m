//
//  SGViewController.m
//  BabyDiary
//
//  Created by 成基 朴 on 12/07/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SGViewController.h"

@interface SGViewController ()


@end

@implementation SGViewController
@synthesize delegate = _delegate;
@synthesize calendarDiary = _calendarDiary;
@synthesize dayLabel = _dayLabel;
@synthesize dayOfWeek = _dayOfWeek;
@synthesize diaryWrite = _diaryWrite;
@synthesize babyDiaryDataList = _babyDiaryDataList;
@synthesize day = _day;
@synthesize weekOfDay = _weekOfDay;
@synthesize myDiaryContents = _myDiaryContents;





-(DayTimeName *)babyDiaryDataList{
    if(!_babyDiaryDataList){
        _babyDiaryDataList = [[DayTimeName alloc]init];
        
    }
   
    return _babyDiaryDataList;
}

-(CalendarData *)calendarDiary{
    if(_calendarDiary == nil){
        _calendarDiary = [[CalendarData alloc]init];
        
    }
    return _calendarDiary;
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}

-(void)firstScene{
    self.dayLabel.text = self.calendarDiary.myDay;
    self.dayOfWeek.text = self.calendarDiary.myDayOfWeek;
    self.diaryWrite.text = self.calendarDiary.myDiaryContents;
}

-(void)navi{
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"SAVE" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction:)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)viewDidLoad
{
    [self navi];
    [self firstScene];    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setDayLabel:nil];
    [self setDayOfWeek:nil];
    [self setDiaryWrite:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)saveAction:(UIBarButtonItem *)sender {

    self.calendarDiary.myDiaryContents = [self.diaryWrite.text copy];
    [self.delegate detailViewController:self didChangeCalendarData:self.calendarDiary ];
  
}


- (void)keyboardWillShow:(NSNotification *)aNotification 
{
   
	// the keyboard is showing so resize the table's height
	CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration =
	[[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.diaryWrite.frame;
    frame.size.height -= keyboardRect.size.height +43 ;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.diaryWrite.frame = frame;
    
  
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    
    //   self.view.frame = CGRectMake(0, 70, 320, 360);
    
    // the keyboard is hiding reset the table's height
	CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration =
	[[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.diaryWrite.frame;
    frame.size.height += keyboardRect.size.height +43 ;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.diaryWrite.frame = frame;
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated 
{
   
	[super viewWillAppear:animated];
	
    // listen for keyboard hide/show notifications so we can properly adjust the table's height
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated 
{
    [super viewDidDisappear:animated];
	
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}
@end
