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
@property (strong, nonatomic) NSDictionary *appList;
@property (strong, nonatomic) NSArray *appsKey;

@property (strong, nonatomic) NSDictionary *dict;
@property (strong,nonatomic) NSMutableArray *myArray;
@property (strong,nonatomic) NSMutableArray *dayOfWeekArray;
@property (strong, nonatomic) NSMutableArray *diaryContents;
@end
