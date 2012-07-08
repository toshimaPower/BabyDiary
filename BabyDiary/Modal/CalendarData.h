//
//  CalendarData.h
//  BabyDiary
//
//  Created by psg4 on 12. 7. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarData : NSObject

@property int gyear;
@property int gmonth;
@property int gday;
@property int m_aday;
@property int m_bday;
@property (nonatomic, strong) NSMutableArray *myArray;
@property (nonatomic, strong) NSMutableArray *dayOfWeekArray;

@property (nonatomic,strong) NSString *myDay;
-(int)isLeapYear:(int)year;
-(int)getLastDay:(int)year month:(int)month;
-(int)zeller:(int)year month:(int)month day:(int)day;



-(void)movePrevMonth;
-(void)moveNextMonth;



-(void)moveCurrentDate;
-(void)fastEnum:(int)year withMonth:(int)month;


@end
