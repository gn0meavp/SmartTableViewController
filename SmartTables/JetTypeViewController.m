//
//  JetTypeViewController.m
//  SmartTables
//
//  Created by Alexey Patosin on 5/28/12.
//  Copyright (c) 2012 Yota Labs LLC, Russia. All rights reserved.
//

#import "JetTypeViewController.h"

@implementation JetTypeViewController

- (id)initWithJet:(Jet *)jet{
    if(self = [super initWithStyle:UITableViewStyleGrouped]){
        _jet = [jet retain];
    }
    return self;
}

- (void)dealloc{
    [_jet release];
    [super dealloc];
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Type";
}

- (void)updateSections{
    [super updateSections];
    //TODO: implement this   
    [self.tableView reloadData];
}

@end
