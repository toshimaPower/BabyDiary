

//
//  DiaryContentsViewController.m
//  BabyDiary
//
//  Created by psg4 on 12. 7. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "DiaryContentsViewController.h"

@interface DiaryContentsViewController ()

@end

@implementation DiaryContentsViewController

@synthesize delegate = _delegate;
@synthesize calendarDiary = _calendarDiary;
@synthesize dayLabel = _dayLabel;
@synthesize dayOfWeek = _dayOfWeek;
@synthesize diaryWrite = _diaryWrite;
@synthesize babyDiaryDataList = _babyDiaryDataList;
@synthesize day = _day;
@synthesize weekOfDay = _weekOfDay;
@synthesize myDiaryContents = _myDiaryContents;
@synthesize textView = _textView;


-(void)tt{
    NSLog(@"__%f",self.diaryWrite.frame.origin.x);
    NSLog(@"__%f",self.diaryWrite.frame.origin.y);
    NSLog(@"__%f",self.diaryWrite.frame.size.width);
    NSLog(@"__%f",self.diaryWrite.frame.size.height);
}




-(DayTimeName *)babyDiaryDataList{
    if(!_babyDiaryDataList){
        _babyDiaryDataList = [[DayTimeName alloc]init];
        NSLog(@"_babyDiaryDataList");
    }
    NSLog(@"babydiaryData world");
    return _babyDiaryDataList;
}

-(CalendarData *)calendarDiary{
    if(_calendarDiary == nil){
        _calendarDiary = [[CalendarData alloc]init];
        NSLog(@"calendarDiary");
    }
    return _calendarDiary;
}


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
    [self tt];
    self.dayLabel.text = self.calendarDiary.myDay;
    self.dayOfWeek.text = self.calendarDiary.myDayOfWeek;
    self.diaryWrite.text = self.calendarDiary.myDiaryContents;
    
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


- (IBAction)saveAction:(UIBarButtonItem *)sender {
    
    
 //   NSMutableString *diary = [[NSMutableString alloc]init];
   
    
     self.calendarDiary.myDiaryContents = [self.diaryWrite.text copy];
    [self.delegate detailViewController:self didChangeCalendarData:self.calendarDiary ];
    
    
    
}


- (void)keyboardWillShow:(NSNotification *)aNotification 
{
    NSLog(@"123");
	// the keyboard is showing so resize the table's height
	CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration =
	[[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.diaryWrite.frame;
    frame.size.height -= keyboardRect.size.height ;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.diaryWrite.frame = frame;
    
    NSLog(@"12");
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    
    //   self.view.frame = CGRectMake(0, 70, 320, 360);
    NSLog(@"23");
    // the keyboard is hiding reset the table's height
	CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration =
	[[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.diaryWrite.frame;
    frame.size.height += keyboardRect.size.height ;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.diaryWrite.frame = frame;
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated 
{
    NSLog(@"124sdf");
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
