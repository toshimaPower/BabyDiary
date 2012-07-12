//
//  DiaryTableViewController.m
//  BabyDiary
//
//  Created by psg4 on 12. 7. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "DiaryTableViewController.h"
#import "DiaryCustomCell.h"
#import "DiaryContentsViewController.h"

@interface DiaryTableViewController ()<DiaryContentsViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *diary_List;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation DiaryTableViewController
@synthesize calendar = _calendar;

@synthesize dayButton = _dayButton;


@synthesize myArray = _myArray;
@synthesize dayOfWeekArray = _dayOfWeekArray;
@synthesize diaryContents = _diaryContents;

@synthesize diary_List = _diary_List;
@synthesize indexPath = _indexPath;


-(void)makeFirstTableView{
    
   
    int i = self.calendar.gday -1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

-(void)saveData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *babyDiaryList = [NSMutableArray array];
    for (CalendarData *data in self.calendar.babyDiaryList) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              data.myDay,@"Diary_Day",
                              data.myDayOfWeek,@"Diary_Day_of_Week",
                              data.myDiaryContents,@"Diary_Contents",nil];
        [babyDiaryList addObject:dict];
    }
    [defaults setObject:babyDiaryList forKey:[NSString stringWithFormat:@"babyDiaryList %i %i",self.calendar.gyear,self.calendar.gmonth]];
    [defaults synchronize];
}

-(void)loadData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *babyDiaryListLoad = [defaults objectForKey:[NSString stringWithFormat:@"babyDiaryList %i %i",self.calendar.gyear,self.calendar.gmonth]];
    
    if (babyDiaryListLoad) {
        [self.calendar.babyDiaryList removeAllObjects];
        for (NSDictionary *dict in babyDiaryListLoad) {
            CalendarData *data = [[CalendarData alloc]init];
            data.myDay = [dict objectForKey:@"Diary_Day"];
            data.myDayOfWeek = [dict objectForKey:@"Diary_Day_of_Week"];
            data.myDiaryContents = [dict objectForKey:@"Diary_Contents"];
            [self.calendar.babyDiaryList addObject:data];
        }
    }
    
    
}
 
-(void)gestureRight{
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(next:)];
    right.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:right];
}
-(void)gestureLeft{
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(prevDay:)];
    left.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:left];
    

}
- (IBAction)todayButton:(id)sender {
    NSLog(@"today");
    
    [self.calendar moveCurrentDate];
    [self.calendar getLastDay:self.calendar.gyear month:self.calendar.gmonth];
    [self.calendar fastEnum:self.calendar.gyear withMonth:self.calendar.gmonth];
    [self.dayButton setTitle:[NSString stringWithFormat:@"%i 년 %i 월 ",self.calendar.gyear,self.calendar.gmonth] forState:UIControlStateNormal];
    
    [self loadData];
    [self.tableView reloadData];

  //  NSLog(@"today %@",[self.calendar moveCurrentDate]);
}

-(CalendarData *)calendar{
    if(!_calendar){
        _calendar = [[CalendarData alloc]init];
        [_calendar moveCurrentDate];
        NSLog(@"init %i",_calendar.gday);
        [self.calendar moveCurrentDate];
        
    }
    return _calendar;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self.calendar fastEnum:self.calendar.gyear withMonth:self.calendar.gmonth];
 //   self.dayButton.titleLabel.text = [NSString stringWithFormat:@"%i 년 %i 월 ",self.calendar.gyear,self.calendar.gmonth];
    [self.dayButton setTitle:[NSString stringWithFormat:@"%i 년 %i 월 ",self.calendar.gyear,self.calendar.gmonth] forState:UIControlStateNormal];
    [self loadData];
    [self gestureLeft];
    [self gestureRight];
    [self makeFirstTableView];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setCalendar:nil];
   
    [self setDayButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
      //  return [self.calendar getLastDay:self.calendar.gyear month:self.calendar.gmonth];
    return self.calendar.babyDiaryList.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
   
    DiaryCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"show_detail"];
    CalendarData *data = [self.calendar.babyDiaryList objectAtIndex:indexPath.row];
    cell.dayLabel.text = data.myDay;
    cell.weekOfDayLabel.text = data.myDayOfWeek;
    cell.diaryWrite.text = data.myDiaryContents;
    
    
    
    return cell;
}

#pragma mark - Table view delegate
/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"Hello");
  //  if([[segue identifier]isEqualToString:@"show_detail"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow ];
 //       DayTimeName *diarydaTa = [self.calendar.myArray objectAtIndex:indexPath.row];
        DiaryContentsViewController *viewController =(DiaryContentsViewController *)[segue destinationViewController];
      //  viewController.babyDiaryDataList = diarydaTa;
        viewController.day =  [self.myArray objectAtIndex:indexPath.row];
        viewController.weekOfDay = [self.dayOfWeekArray objectAtIndex:indexPath.row];
        NSLog(@"vieController.day %@",viewController.day);
        NSLog(@"viewController.weekOfDay %@",viewController.weekOfDay);
        
   // }
}

*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   
    if([[segue identifier] isEqualToString:@"show_detail"]){
        self.indexPath = [self.tableView indexPathForSelectedRow];
        CalendarData *data = [self.calendar.babyDiaryList objectAtIndex:self.indexPath.row];
        DiaryContentsViewController *viewController = [segue destinationViewController];
        viewController.calendarDiary = data; 
        viewController.delegate = self;
    }
}

-(void)detailViewController:(DiaryContentsViewController *)viewController didChangeCalendarData:(CalendarData *)diaryList{
    [self.navigationController popViewControllerAnimated:YES];
 //    self.indexPath = [self.tableView indexPathForSelectedRow];   
    [self.calendar.babyDiaryList replaceObjectAtIndex:self.indexPath.row withObject:diaryList];
    [self.tableView reloadData];
    [self saveData];
}



#pragma mark - Table view delegate

- (void)prevDay:(UIBarButtonItem *)sender {
   
    [self.calendar movePrevMonth];
    
    [self.calendar getLastDay:self.calendar.gyear month:self.calendar.gmonth];
    [self.calendar fastEnum:self.calendar.gyear withMonth:self.calendar.gmonth];
   [self.dayButton setTitle:[NSString stringWithFormat:@"%i 년 %i 월 ",self.calendar.gyear,self.calendar.gmonth] forState:UIControlStateNormal];
    
    [self loadData];
    [self.tableView reloadData];
    
    
    
}

- (void)next:(UIBarButtonItem *)sender {
    [self.calendar moveNextMonth];
    [self.calendar fastEnum:self.calendar.gyear withMonth:self.calendar.gmonth];
    [self.dayButton setTitle:[NSString stringWithFormat:@"%i 년 %i 월 ",self.calendar.gyear,self.calendar.gmonth] forState:UIControlStateNormal];
    [self.calendar getLastDay:self.calendar.gyear month:self.calendar.gmonth];
    [self loadData];
    [self.tableView reloadData];
    
    
}


@end
