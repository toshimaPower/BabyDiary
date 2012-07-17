//
//  DiaryTableViewController.m
//  BabyDiary
//
//  Created by psg4 on 12. 7. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "DiaryTableViewController.h"




#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@interface DiaryTableViewController ()<SGViewControllerDelegate>
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
 
    [self.dayButton setTitle:[NSString stringWithFormat:@"%i 년 %i 월 ",self.calendar.gyear,self.calendar.gmonth] forState:UIControlStateNormal];
    [self loadData];
    [self gestureLeft];
    [self gestureRight];
    [self makeFirstTableView];
    [super viewDidLoad];

   
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"helloTest1");
    
    CalendarData *data = [self.calendar.babyDiaryList objectAtIndex:indexPath.row];
    
    NSString *text = data.myDiaryContents;
    
    CGSize constraint = CGSizeMake(240 , 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + (CELL_CONTENT_MARGIN * 2);
}
/*
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"456");
    static NSString *CellIdentifier = @"show_detail";
    self.cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    CalendarData *data = [self.calendar.babyDiaryList objectAtIndex:indexPath.row];
    
    
    
    self.cell.dayLabel.text = data.myDay;
    self.cell.weekOfDayLabel.text = data.myDayOfWeek;
    self.cell.diaryWrite.text = data.myDiaryContents;
    
    
    
    return self.cell;
}
 
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *sg = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    UILabel *label = nil;
    UILabel *label2 = nil;
    UILabel *label3 = nil;
    
    if(sg == nil){
        sg = [[UITableViewCell alloc]initWithFrame:CGRectZero];
        label = [[UILabel alloc]initWithFrame:CGRectMake(70,10, 240, 0)];
        label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 20)];
        label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 50, 20)];
        
        
        NSLog(@"____%@",label);
        [label setLineBreakMode:UILineBreakModeWordWrap];
        [label setMinimumFontSize:FONT_SIZE];
        [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        [label setNumberOfLines:0];
        [label setTag:1];
        [label setBackgroundColor:[UIColor greenColor]];
        [[sg contentView]addSubview:label];
        
        [label2 setLineBreakMode:UILineBreakModeWordWrap];
        [label2 setMinimumFontSize:FONT_SIZE];
        [label2 setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        [label2 setNumberOfLines:0];
        [label2 setTag:2];
        [label2 setBackgroundColor:[UIColor yellowColor]];
        [[sg contentView]addSubview:label2];
        
        [label3 setLineBreakMode:UILineBreakModeWordWrap];
        [label3 setMinimumFontSize:FONT_SIZE];
        [label3 setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        [label3 setNumberOfLines:0];
        [label3 setTag:3];
        [label3 setBackgroundColor:[UIColor redColor]];
        [[sg contentView]addSubview:label3];
        
    }
   
    CalendarData *data = [self.calendar.babyDiaryList objectAtIndex:indexPath.row];
    NSString *text = data.myDiaryContents;
    CGSize constraint = CGSizeMake( 240, 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    // Configure the cell...
    if (!label){
        label = (UILabel*)[sg viewWithTag:1];
        label2 = (UILabel*)[sg viewWithTag:2];
        label3 = (UILabel*)[sg viewWithTag:3];}
    [label setText:text];
    [label setFrame:CGRectMake(70,10, 240, MAX(size.height, 44.0f))];
    [label2 setText:data.myDay];
    [label3 setText:data.myDayOfWeek];
    
   
    
    return sg;
}


#pragma mark - Table view delegate
/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CalendarData *data = [self.calendar.babyDiaryList objectAtIndex:indexPath.row];
        DiaryContentsViewController *detailView = [[DiaryContentsViewController alloc]initWithNibName:@"DiaryContentViewController" bundle:nil];
    detailView.calendarDiary = data;
    
    [self.navigationController pushViewController:detailView animated:YES];
    NSLog(@"sdfasc");
}
*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.indexPath = [tableView indexPathForSelectedRow];
    CalendarData *data = [self.calendar.babyDiaryList objectAtIndex:self.indexPath.row];
    SGViewController *detailView = [[SGViewController alloc]initWithNibName:@"SGViewController" bundle:nil];
    detailView.calendarDiary = data;
    detailView.delegate = self;
    [self.navigationController pushViewController:detailView animated:YES];
   
}


-(void)detailViewController:(SGViewController *)viewController didChangeCalendarData:(CalendarData *)diaryList{
    
    [self.navigationController popViewControllerAnimated:YES];
  //   self.indexPath = [self.tableView indexPathForSelectedRow];   
    [self.calendar.babyDiaryList replaceObjectAtIndex:self.indexPath.row withObject:diaryList];
    [self.tableView reloadData];
    [self saveData];
}



#pragma mark - Table view delegate

-(void)makeTableViewList{
    [self.calendar fastEnum:self.calendar.gyear withMonth:self.calendar.gmonth];
    [self.dayButton setTitle:[NSString stringWithFormat:@"%i 년 %i 월 ",self.calendar.gyear,self.calendar.gmonth] forState:UIControlStateNormal];
    [self.calendar getLastDay:self.calendar.gyear month:self.calendar.gmonth];
    [self loadData];
    [self.tableView reloadData];
}

- (void)prevDay:(UIBarButtonItem *)sender {
   
    [self.calendar movePrevMonth];
    
    [self makeTableViewList];
    
    
    
}

- (void)next:(UIBarButtonItem *)sender {
    [self.calendar moveNextMonth];
    [self makeTableViewList];
    
}

@end
