//
//  DiaryTableViewController.m
//  BabyDiary
//
//  Created by psg4 on 12. 7. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "DiaryTableViewController.h"

@interface DiaryTableViewController ()

@end

@implementation DiaryTableViewController
@synthesize calendar = _calendar;
@synthesize dayLabel = _dayLabel;
@synthesize dayOfWeekDay = _dayOfWeekDay;

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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    NSString *text = [self.calendar.myArray objectAtIndex:indexPath.row];
    
    NSString *text2 = [self.calendar.dayOfWeekArray objectAtIndex:indexPath.row];
    
    self.dayLabel = (UILabel *)[cell viewWithTag:0];
    self.dayLabel.text = text;
    self.dayOfWeekDay = (UILabel *)[cell viewWithTag:1];
    self.dayOfWeekDay.text = text2;
    NSLog(@"%@  %@",text,text2);
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier]isEqualToString:@"show_detail"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow ];
        DayTimeName *diarydaTa = [self.calendar.myArray objectAtIndex:indexPath.row];
        DiaryContentsViewController *viewController = segue.destinationViewController;
        viewController.babyDiaryDataList = diarydaTa;
        viewController.delegate = self;
        
        
    }
}
*/

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
