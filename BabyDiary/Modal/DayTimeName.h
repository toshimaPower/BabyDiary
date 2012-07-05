//
//  DayTimeName.h
//  BabyDiary
//
//  Created by psg4 on 12. 7. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DayTimeName : NSObject


@property (nonatomic , strong) NSDate *birthDay;
@property (nonatomic , strong) NSString *babyName; 

/*
 -(NSString *)getPath;
 -(void)makePlist;
 -(void)loadPlist;
 -(void)savePlist;
 */

@property (nonatomic) int day;
@property (nonatomic) int hour;
@property (nonatomic) int minute;
@property (nonatomic) int second;
-(void)time:(NSDate *)aTime;
-(void)loadData;
-(void)persistWithName:(NSString *)name birthDay:(NSDate *)aBirthDay;

@end
