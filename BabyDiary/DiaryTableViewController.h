//
//  DiaryTableViewController.h
//  BabyDiary
//
//  Created by psg4 on 12. 7. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGViewController.h"


@interface DiaryTableViewController : UITableViewController

@property (nonatomic, strong) CalendarData *calendar;


@property (weak, nonatomic) IBOutlet UIButton *dayButton;

@property (strong,nonatomic) NSMutableArray *myArray;
@property (strong,nonatomic) NSMutableArray *dayOfWeekArray;
@property (strong, nonatomic) NSMutableArray *diaryContents;
@end
