//
//  ViewController.m
//  BabyDiary
//
//  Created by psg4 on 12. 7. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "DayTimeName.h"
@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController
@synthesize dayTimeName = _dayTimeName;
@synthesize nameTextfield = _nameTextfield;
@synthesize birthDate = _birthDate;
@synthesize datePicker = _datePicker;

-(DayTimeName *)dayTimeName{
    if(!_dayTimeName){
        _dayTimeName = [[DayTimeName alloc]init];
    }
    return _dayTimeName;
}

-(void)today{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy 년 MM 월 dd 일"];
    self.birthDate.text = [formatter stringFromDate:[NSDate date]];

    
}
- (void)viewDidLoad
{
    [self today];
    self.nameTextfield.delegate = self;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setNameTextfield:nil];
    [self setBirthDate:nil];
    [self setDatePicker:nil];

    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self nameTextfield]resignFirstResponder];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)changeDatePicker:(UIDatePicker *)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy 년 MM 월 dd 일"];
    self.birthDate.text = [formatter stringFromDate:sender.date];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSLog(@"touch");
    return YES;
}


- (IBAction)saveDate:(UIBarButtonItem *)sender {
        self.dayTimeName.babyName = self.nameTextfield.text;
        self.dayTimeName.birthDay = self.datePicker.date;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if(!self.dayTimeName){
        self.dayTimeName = [[DayTimeName alloc]init];
        self.dayTimeName.babyName = self.nameTextfield.text;
        self.dayTimeName.birthDay = self.datePicker.date;
    }
    [[self dayTimeName]persistWithName:self.nameTextfield.text birthDay:self.datePicker.date];

    
    
    
}


@end
