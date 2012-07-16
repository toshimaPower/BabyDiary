//
//  DiaryCustomCell.m
//  BabyDiary
//
//  Created by psg4 on 12. 7. 6..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "DiaryCustomCell.h"

@implementation DiaryCustomCell
@synthesize dayLabel = _dayLabel;
@synthesize weekOfDayLabel = _weekOfDayLabel;
@synthesize diaryWrite = _diaryWrite;
@synthesize testLabel = _testLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc{
    [self setDayLabel:nil];
    [self setWeekOfDayLabel:nil];
    
}

@end
