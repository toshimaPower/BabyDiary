//
//  MainCountDownViewController.m
//  BabyDiary
//
//  Created by psg4 on 12. 7. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "MainCountDownViewController.h"
#import "DayTimeName.h"

@interface MainCountDownViewController ()

@end

@implementation MainCountDownViewController
@synthesize date = _date;
@synthesize name = _name;
@synthesize time = _time;
@synthesize dayLabel = _dayLabel;
@synthesize hourLabel = _hourLabel;
@synthesize minuteLabel = _minuteLabel;
@synthesize secondLabel = _secondLabel;
@synthesize pergnancy = _pergnancy;

-(DayTimeName *)date{
    if(!_date){
        _date = [[DayTimeName alloc]init];
    }
    return _date;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


 -(void)timer {
  [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(runTime) userInfo:nil repeats:YES];

 }

-(void)runTime{
    [self.date time:self.date.birthDay];
    self.dayLabel.text = [NSString stringWithFormat:@"%i 일",self.date.day];
    self.hourLabel.text = [NSString stringWithFormat:@"%i 시간",self.date.hour];
    self.minuteLabel.text = [NSString stringWithFormat:@"%i 분",self.date.minute];
    self.secondLabel.text = [NSString stringWithFormat:@"%i 초",self.date.second];
   
}


- (void)viewDidLoad
{
    [[self date]loadData];
    self.name = self.date.babyName;
    self.time = self.date.birthDay;
    NSLog(@"baby Name is %@",self.name);
    NSLog(@"baby BirthDay is %@",self.time);
    [super viewDidLoad];
    [self.date time:self.date.birthDay];
	// Do any additional setup after loading the view.
//    [self timer];
    self.dayLabel.text = [NSString stringWithFormat:@"%i 일",self.date.day];
    self.hourLabel.text = [NSString stringWithFormat:@"%i 시간",self.date.hour];
    self.minuteLabel.text = [NSString stringWithFormat:@"%i 분",self.date.minute];
    self.secondLabel.text = [NSString stringWithFormat:@"%i 초",self.date.second];
   
    //    NSTimer *tm = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(runTime) userInfo:nil repeats:YES];

}

- (void)viewDidUnload
{
    [self setName:nil];
    [self setTime:nil];
    [self setDayLabel:nil];
    [self setHourLabel:nil];
    [self setMinuteLabel:nil];
    [self setSecondLabel:nil];
    [self setPergnancy:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
