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

@interface DiaryTableViewController ()

@end

@implementation DiaryTableViewController
@synthesize calendar = _calendar;
@synthesize dayLabel = _dayLabel;
@synthesize dayOfWeekDay = _dayOfWeekDay;
@synthesize appList = _appList;
@synthesize appsKey = _appsKey;

@synthesize myArray = _myArray;
@synthesize dayOfWeekArray = _dayOfWeekArray;
@synthesize diaryContents = _diaryContents;
@synthesize dict = _dict;

/*
-(void)loadData{
    NSLog(@"world12");
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"world123");
      self.appList = [defaults objectForKey:[NSString stringWithFormat:@"babyDiaryList %i %i",self.calendar.gyear,self.calendar.gmonth]];
    NSLog(@"world1234");
    self.appsKey = [[self.appList allKeys] sortedArrayUsingSelector:@selector(compare:)];
 
    NSLog(@"world12345");
    NSLog(@"ss %@",self.appList);
}
*/



-(void)loadData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *babyDiaryListLoad = [defaults objectForKey:[NSString stringWithFormat:@"babyDiaryList %i %i",self.calendar.gyear,self.calendar.gmonth]];
    
    self.myArray  = [[NSMutableArray alloc]init];
    self.dayOfWeekArray = [[NSMutableArray alloc]init];
   
    if(babyDiaryListLoad){
        
        for(_dict in babyDiaryListLoad){
            //     CalendarData *data = [[CalendarData alloc]init];
            [self.dayOfWeekArray addObject:[_dict objectForKey:@"Diary_Day_of_Week"]];
            [self.diaryContents addObject: [_dict objectForKey:@"Diary_contents"]];
            [self.myArray addObject:[_dict objectForKey:@"Diary_Day"]];
        }
    }
//    self.appsKey= [[_dict allKeys]sortedArrayUsingSelector:@selector(compare:)];
    
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
    self.navigationItem.title = [NSString stringWithFormat:@"%i 년 %i 월 ",self.calendar.gyear,self.calendar.gmonth];
    [self loadData];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setCalendar:nil];
    [self setDayLabel:nil];
    [self setDayOfWeekDay:nil];
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
    return [self.calendar getLastDay:self.calendar.gyear month:self.calendar.gmonth];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  

    DiaryCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"show_detail"];
    cell.dayLabel.text = [self.myArray objectAtIndex:indexPath.row];
    cell.weekOfDayLabel.text = [self.dayOfWeekArray objectAtIndex:indexPath.row];
    cell.diaryWrite.text = [self.diaryContents objectAtIndex:indexPath.row];
    return cell;

}

#pragma mark - Table view delegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
   //  <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    DiaryContentsViewController *viewController = [[DiaryContentsViewController alloc]initWithNibName:@"DiaryContentsViewController" bundle:nil];
    //  viewController.babyDiaryDataList = diarydaTa;
    viewController.day=  [self.myArray objectAtIndex:indexPath.row];
    viewController.weekOfDay = [self.dayOfWeekArray objectAtIndex:indexPath.row]; 
    
    // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:viewController animated:YES];
     
}

*/
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


-(void)detailViewController:(DiaryContentsViewController *)viewController didChangeCalendarDate:(CalendarData *)diaryList{
  //  [self.diaryListData addObject:diaryList];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Table view delegate
- (IBAction)prevDay:(UIBarButtonItem *)sender {
    [self.calendar movePrevMonth];
    
    [self.calendar getLastDay:self.calendar.gyear month:self.calendar.gmonth];
    [self.calendar fastEnum:self.calendar.gyear withMonth:self.calendar.gmonth];
    self.navigationItem.title = [NSString stringWithFormat:@"%i 년 %i 월 ",self.calendar.gyear,self.calendar.gmonth];
    
    NSLog(@"%i 년 %i 월 ",self.calendar.gyear,self.calendar.gmonth);
    [self.tableView reloadData];
    
    
    
}

- (IBAction)next:(UIBarButtonItem *)sender {
    [self.calendar moveNextMonth];
    
    [self.calendar fastEnum:self.calendar.gyear withMonth:self.calendar.gmonth];
    self.navigationItem.title = [NSString stringWithFormat:@"%i 년 %i 월 ",self.calendar.gyear,self.calendar.gmonth];
    
    
    [self.calendar getLastDay:self.calendar.gyear month:self.calendar.gmonth];
    [self.tableView reloadData];
    
}


@end
