//
//  ClientPageViewController.m
//  LogMe
//
//  Created by Jack on 6/12/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "ClientPageViewController.h"
#import "ClientPageController.h"
#import "Constants.h"
#import "Client.h"

@interface ClientPageViewController ()
@property (strong, nonatomic) IBOutlet UITableView *clientTable;
@property (strong, nonatomic) IBOutlet UILabel *clientNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *clientRateLabel;

@end

@implementation ClientPageViewController {
    ClientPageController *controller;
    
    NSMutableArray *clientNameArray;
}


-(void) viewDidAppear:(BOOL)animated {
    [self refreshClients];
    
    ADBannerView *adView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 115, 320, 50)];
    adView.delegate = self;
    [self.view addSubview:adView];
}

-(void) refreshClients {
    
    [controller loadClientList];
    
    [self loadClients];
    
    [_clientTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    controller = [[ClientPageController alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    _clientTable.dataSource = self;
    _clientTable.delegate = self;
    
    [self loadClients];
    
}

-(void) loadClients {
    
    clientNameArray = [NSMutableArray array];
    
    for(Client *client in controller.clientList.list) {
        [clientNameArray addObject:client.name];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [clientNameArray count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"LogsCell";
    UITableViewCell *thisCell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(thisCell == nil) {
        thisCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    if(indexPath.row == [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentClient"] intValue]) {
        thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        thisCell.accessoryType = nil;
    }
    
    thisCell.textLabel.text = clientNameArray[indexPath.row];
    //thisCell.detailTextLabel.text = subtitleArray[indexPath.row];
    return thisCell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt: indexPath.row] forKey:@"currentClient"];
    [_clientTable reloadData];
    
    Client *currentClient = controller.clientList.list[indexPath.row];
    _clientNameLabel.text = currentClient.name;
    _clientRateLabel.text = [NSString stringWithFormat:@"$%.2f / hr", currentClient.rate];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [controller removeClientAtIndex:indexPath.row];
    [self refreshClients];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to retrieve ad");
}

@end
