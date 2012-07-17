//
//  SGViewController.h
//  BabyDiary
//
//  Created by 成基 朴 on 12/07/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayTimeName.h"
#import "CalendarData.h"

@class SGViewController;
@protocol SGViewControllerDelegate <NSObject>

-(void)detailViewController:(SGViewController *)viewController didChangeCalendarData:(CalendarData *)diaryList;
@end

@interface SGViewController : UIViewController

@property (nonatomic, strong) NSString *day;
@property (nonatomic, strong) NSString *weekOfDay;
@property (nonatomic, strong) NSString *myDiaryContents;


@property (nonatomic, strong) DayTimeName *babyDiaryDataList;
@property (nonatomic, strong) CalendarData *calendarDiary;


@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayOfWeek;
@property (weak, nonatomic) IBOutlet UITextView *diaryWrite;



@property (nonatomic, weak) id<SGViewControllerDelegate> delegate; 


@end
