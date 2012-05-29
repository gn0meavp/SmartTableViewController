//
//  PilotViewController.m
//  SmartTables
//
//  Created by Alexey Patosin (alexey@patosin.ru) on 5/28/12.
//

#import "PilotViewController.h"

NSString *pilotNameCellId = @"pilotNameCell";
NSString *pilotNameSectionId = @"pilotNameSection";

@implementation PilotViewController

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
    
    self.navigationItem.title = @"Pilot";
}

- (EditTableViewCell *)pilotNameCell{
    EditTableViewCell *cell = [EditTableViewCell cellWithCellId:pilotNameCellId];
    
    __block typeof(self) bself = self;
    
    cell.keyTextLabel.text = @"Name";
    
    [cell setCalledBlock:^{
        bself->_jet.pilot.name = cell.valueTextField.text;
    }];
    
    [self addNotificationObserver:@"PilotNameChanged" object:_jet.pilot usingBlock:^(NSNotification *notification) {
        cell.valueTextField.text = bself->_jet.pilot.name;
    } calledBlockImmediately:YES];
    
    [cell setAccessoryType:UITableViewCellAccessoryNone];       //because we have calledBlock here
    
    return cell;
}

- (TableSectionContainer *)pilotNameSection{
    TableSectionContainer *section = [TableSectionContainer sectionWithSectionId:pilotNameSectionId];
    
    [section.cells addObject:[self pilotNameCell]];
    
    return section;
}

- (void)updateSections{
    [super updateSections];

    [self.sections addObject:[self pilotNameSection]];
    
    [self.tableView reloadData];
}

@end
