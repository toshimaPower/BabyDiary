//
//  DiaryContentsViewController.h
//  BabyDiary
//
//  Created by psg4 on 12. 7. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayTimeName.h"
#import "CalendarData.h"

@class DiaryContentsViewController;
@protocol DiaryContentsViewControllerDelegate <NSObject>

-(void)detailViewController:(DiaryContentsViewController *)viewController didChangeCalendarData:(CalendarData *)diaryList;
@end

@interface DiaryContentsViewController : UIViewController

@property (nonatomic, strong) NSString *day;

@property (nonatomic, strong) NSString *weekOfDay;


@property (nonatomic, strong) DayTimeName *babyDiaryDataList;
@property (nonatomic, strong) CalendarData *calendarDiary;

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayOfWeek;
@property (weak, nonatomic) IBOutlet UITextView *diaryWrite;


@property (nonatomic, weak) id<DiaryContentsViewControllerDelegate> delegate; 


@end
