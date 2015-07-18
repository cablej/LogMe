//
//  SecondViewController.m
//  LogMe
//
//  Created by Jack on 6/11/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "SecondViewController.h"
#import "LogViewingController.h"
#import "Constants.h"
#import "WorkLog.h"
#import "AddLogViewController.h"
#import "Client.h"

@interface SecondViewController ()
            
@property (strong, nonatomic) IBOutlet UITableView *logsTable;

@property (strong, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *hoursWorkedLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *moneyEarnedLabel;

@end

@implementation SecondViewController {
    NSMutableArray *logsArray;
    NSMutableArray *subtitleArray;
    LogViewingController *logViewingController;
    
    WorkLogList *clientLogArray;
}

-(void) viewDidAppear:(BOOL)animated {
    [self refreshLogs];
}

-(void) refreshLogs {
    [self loadLogs];
    
    [self.logsTable reloadData];
}

-(void) loadLogs {
    [logViewingController loadClientsFromFile:logFile];
    
    logsArray = [NSMutableArray array];
    subtitleArray = [NSMutableArray array];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"currentClient"] intValue] > (int) logViewingController.allClients.list.count - 1) {
        clientLogArray = [WorkLogList workLogList];
        return;
    } else {
        clientLogArray = ((Client*)logViewingController.allClients.list[[[[NSUserDefaults standardUserDefaults] objectForKey:@"currentClient"] intValue]]).logs;
    }
    
    for(WorkLog *log in clientLogArray.list) {
        [logsArray addObject:[log getFormattedTimeElapsedLong]];
        [subtitleArray addObject:[log getFormattedEndDate]];
    }
}
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    logViewingController = [[LogViewingController alloc] init];
    
    [self loadLogs];
    
    _logsTable.dataSource = self;
    _logsTable.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [logsArray count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"LogsCell";
    UITableViewCell *thisCell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(thisCell == nil) {
        thisCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    thisCell.textLabel.text = logsArray[indexPath.row];
    thisCell.detailTextLabel.text = subtitleArray[indexPath.row];
    return thisCell; 
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WorkLog *log = clientLogArray.list[indexPath.row];
    
    _startTimeLabel.text = [NSString stringWithFormat:@"%@ - %@", [log getFormattedStartTime], [log getFormattedEndTime]];
    _hoursWorkedLabel.text = [NSString stringWithFormat: @"Total time worked: %@", [log getFormattedTimeElapsedVeryLong]];
    _dateLabel.text = [log getFormattedEndDate];
    _moneyEarnedLabel.text = [log getFormattedDollarsEarned];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [logViewingController removeLogAtIndex:indexPath.row];
    [self refreshLogs];
    [self clearLabels];
}

-(void) clearLabels {
    _startTimeLabel.text = @"";
    _hoursWorkedLabel.text = @"";
    _dateLabel.text = @"";
    _moneyEarnedLabel.text = @"";
}

@end
