//
//  JetTypeViewController.m
//  SmartTables
//
//  Created by Alexey Patosin on 5/28/12.
//  Copyright (c) 2012 Yota Labs LLC, Russia. All rights reserved.
//

#import "JetTypeViewController.h"

NSString *typesSectionId = @"typesSection";
NSString *typeCellIdTemplate = @"cellType%i";

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

- (CheckTableViewCell *)typeCell:(JetType)type{
    NSString *cellId = [NSString stringWithFormat:typeCellIdTemplate, type];
    CheckTableViewCell *cell = [CheckTableViewCell cellWithCellId:cellId];
    
    __block typeof(self) bself = self;
    
    [cell.textLabel setText:[_jet jetTypeDescForType:type]];
    
    [cell setCalledBlock:^{
        bself->_jet.type = type;
        [bself updateSections];
    }];

    [cell setChecked:(_jet.type == type)];    
        
    return cell;
}

- (TableSectionContainer *)typesSection{
    TableSectionContainer *section = [TableSectionContainer sectionWithSectionId:typesSectionId];
    
    for(int type=1;type<8;type++){
        [section.cells addObject:[self typeCell:type]];
    }
    
    __block typeof(self) bself = self; 
    
    [self addNotificationObserver:@"PilotTypeChanged" object:_jet usingBlock:^(NSNotification *notification) {
        [bself updateSections];
    } calledBlockImmediately:NO];
        
    return section;
}

- (void)updateSections{
    [super updateSections];

    [self.sections addObject:[self typesSection]];
    
    [self.tableView reloadData];
}

@end
