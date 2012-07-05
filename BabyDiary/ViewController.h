//
//  ViewController.h
//  BabyDiary
//
//  Created by psg4 on 12. 7. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DayTimeName;
@interface ViewController : UIViewController

@property (strong, nonatomic) DayTimeName *dayTimeName;

@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UILabel *birthDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@end
