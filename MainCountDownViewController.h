//
//  MainCountDownViewController.h
//  BabyDiary
//
//  Created by psg4 on 12. 7. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DayTimeName;
@interface MainCountDownViewController : UIViewController


@property (nonatomic, strong) DayTimeName *date;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *time;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *pergnancy;


@end
