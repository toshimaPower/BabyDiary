//
//  DiaryTableViewController.h
//  BabyDiary
//
//  Created by psg4 on 12. 7. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryContentsViewController.h"


@interface DiaryTableViewController : UITableViewController

@property (nonatomic, strong) CalendarData *calendar;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayOfWeekDay;

@end
