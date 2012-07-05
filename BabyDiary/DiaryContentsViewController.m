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
@synthesize textView = _textView;
@synthesize delegate = _delegate;
@synthesize calendarDiary = _calendarDiary;
@synthesize babyDiaryDataList = _babyDiaryDataList;


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
       [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)saveAction:(UIBarButtonItem *)sender {
    
    
    NSMutableString *diary = [[NSMutableString alloc]init];
    diary = [self.textView.text mutableCopy];
    
  //  self.calendarDiary.myDiaryContents = [diary copy];
    [self.delegate detailViewController:self didChangeCalendarData:self.calendarDiary ];
    
    
    
}


@end