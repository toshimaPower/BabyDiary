//
//  DiaryCustomCell.h
//  BabyDiary
//
//  Created by psg4 on 12. 7. 6..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryCustomCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *dayLabel;
@property (nonatomic, weak) IBOutlet UILabel *weekOfDayLabel;
@property (nonatomic, weak) IBOutlet UILabel *diaryWrite;
@end
