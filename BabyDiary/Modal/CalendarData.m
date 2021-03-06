//
//  CalendarData.m
//  BabyDiary
//
//  Created by psg4 on 12. 7. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "CalendarData.h"
@interface CalendarData ()

@end


@implementation CalendarData
@synthesize gyear;
@synthesize gmonth;
@synthesize gday;
@synthesize m_aday;
@synthesize m_bday;


@synthesize myDay = _myDay;
@synthesize myDayOfWeek = _myDayOfWeek;
@synthesize myDiaryContents = _myDiaryContents;
@synthesize babyDiaryList = _babyDiaryList;

//윤년 구하는 법
-(int)isLeapYear:(int)year{
    if(year %400 == 0)       return 1;
    else if(year % 100 == 0) return 0;
    else if(year % 4 == 0)   return 1;
    else                     return 0;
}

//해당 월의 마지막 날을 구하는 함수
-(int)getLastDay:(int)year month:(int)month{
    
    if(month == 2){
        if((BOOL)[self isLeapYear:year]) {return 29;}
        else {return 28;}
    }else if( month == 4 || month == 6 || month == 9 || month == 11) {return 30;}
    else {return 31;}
    
   
    return -1;
}


//요일 구하는 법
-(int)zeller:(int)year month:(int)month day:(int)day
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    [dateComponents setYear:year];
    [dateComponents setDay:day];
    [dateComponents setMonth:month];
    
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *date = [gregorian dateFromComponents:dateComponents];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    return [weekdayComponents weekday] -1;
    
}


//지난달
-(void)movePrevMonth{
    if(gyear >1 && gmonth > 1){
        if(gmonth > 1){
            gmonth --;
            //            if(gday > (m_aday = [self getLastDay:gyear month:gmonth])){
            //                gday = m_aday;
        }
    }else {
        gmonth = 12;
        gyear --;
    }
}
//다음달
-(void)moveNextMonth{
    if(gyear < 9999 && gmonth < 12){
        
        gmonth ++;
        
    }else if(gyear < 9999 && gmonth == 12){
        gmonth = 1;
        gyear ++;
        
    }
    else {
        gmonth = 1;
        gyear = 1;
    }
    
    
}

//오늘

-(void)moveCurrentDate{
    NSDateComponents *today = [[NSCalendar currentCalendar]components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    gyear = [today year];
    gmonth = [today month];
    gday = [today day];
}

//테이블 뷰에 요일
-(NSString *)dayOfThwWeek:(int)aDayOfTheWeek{
    NSString *dayOfWeek;
    if (aDayOfTheWeek == 0) {
        dayOfWeek = @"Sun";
    }
    else if (aDayOfTheWeek == 1) {
        dayOfWeek = @"Mon";
    }
    else if (aDayOfTheWeek == 2) {
        dayOfWeek = @"Tue";
    }
    else if (aDayOfTheWeek == 3) {
        dayOfWeek = @"Wed";
    }
    else if (aDayOfTheWeek == 4) {
        dayOfWeek = @"Thu";
    }
    else if (aDayOfTheWeek == 5) {
        dayOfWeek = @"Fri";
    }
    else if (aDayOfTheWeek == 6) {
        dayOfWeek = @"Sat";
    }
    
  
    return dayOfWeek;
}
-(void)fastEnum:(int)year withMonth:(int)month{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.babyDiaryList = [NSMutableArray array];
    
    NSString *string2 = (NSString *)[defaults objectForKey:[NSString stringWithFormat:@"babyDiaryList %i %i",year,month]];
    if(string2 == nil){
        for(int i = 0; i< [self getLastDay:year month:month];i++){
            
            self.myDay = [NSString stringWithFormat:@"%i 일",i+1];
            self.myDayOfWeek = (NSString *)[self dayOfThwWeek:[self zeller:gyear month:gmonth day:i+1]];
            self.myDiaryContents = [@" " mutableCopy];
                       
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  self.myDay,@"Diary_Day",
                                  self.myDayOfWeek,@"Diary_Day_of_Week",
                                  self.myDiaryContents,@"Diary_Contents",nil];
            [self.babyDiaryList addObject:dict];
          
            
        }
        
        [defaults setObject:self.babyDiaryList forKey:[NSString stringWithFormat:@"babyDiaryList %i %i",year,month] ];
        [defaults synchronize];
        
       
    }
}


/*
-(void)fastEnum:(int)year withMonth:(int)month{
    
    
    myArray  = [[NSMutableArray alloc]init];
    self.dayOfWeekArray = [[NSMutableArray alloc]init];
    
    for(int i = 0; i< [self getLastDay:year month:month];i++){
        NSString *temp = [NSString stringWithFormat:@"%i 일",i+1];
        int first_day_of_week = [self zeller:gyear month:gmonth day:i+1];
       
        
        [myArray addObject:temp];
        [self.dayOfWeekArray addObject:[self dayOfThwWeek:first_day_of_week]];
    }
    for(NSNumber *myNumber in myArray){
        NSLog(@"value : %i",[myNumber intValue]);
    }
   
  
        
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *babyDiaryList = [NSMutableArray array];
    
    NSString *string2 = (NSString *)[defaults objectForKey:[NSString stringWithFormat:@"babyDiaryList %i %i",year,month]];
    if(string2 == nil){
        for(int i = 0; i< [self getLastDay:year month:month];i++){
            NSString *day = [NSString stringWithFormat:@"%i 일",i+1];
            NSString * first_day_of_week = [self dayOfThwWeek:[self zeller:gyear month:gmonth day:i+1]];
            NSMutableString *diaryContents = [@" " mutableCopy];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  day,@"Diary_Day",
                                  first_day_of_week,@"Diary_Day_of_Week",
                                  diaryContents,@"Diary_Contents",nil];
            [babyDiaryList addObject:dict];
            
        }
        
        [defaults setObject:babyDiaryList forKey:[NSString stringWithFormat:@"babyDiaryList %i %i",year,month] ];
        [defaults synchronize];
        
        NSLog(@"SG World");
    }
        
   
    NSArray *babyDiaryListLoad = [defaults objectForKey:[NSString stringWithFormat:@"babyDiaryList %i %i",year,month]];
    
    myArray  = [[NSMutableArray alloc]init];
    self.dayOfWeekArray = [[NSMutableArray alloc]init];
    if(babyDiaryListLoad){
        [babyDiaryList removeAllObjects];
        for(NSDictionary *dic in babyDiaryListLoad){
       //     CalendarData *data = [[CalendarData alloc]init];
            NSString *day = [dic objectForKey:@"Diary_Day"];
            NSString *day_of_week = [dic objectForKey:@"Diary_Day_of_Week"];
          //  NSString *day_diary_contents = [dic objectForKey:@"Diary_contents"];
          
            [myArray addObject:day];
            [self.dayOfWeekArray addObject:day_of_week];
                  
        }
        
    }
   
}
*/
@end
