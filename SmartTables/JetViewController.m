//
//  JetViewController.m
//  SmartTables
//
//  Created by Alexey Patosin on 5/28/12.
//  Copyright (c) 2012 Yota Labs LLC, Russia. All rights reserved.
//

#import "JetViewController.h"
#import "PilotViewController.h"
#import "JetTypeViewController.h"

NSString *jetSectionId = @"jetSection";
NSString *pilotSectionId = @"pilotSection";
NSString *pilotCellId = @"pilotCell";
NSString *jetTypeCellId = @"jetTypeCell";
NSString *serialNumberCellId = @"serialNumberCell";
NSString *pilotOnBoardCellId = @"pilotOnBoardCell";

@implementation JetViewController
@synthesize jet = _jet;

- (void)viewDidLoad{
    _jet = [[Jet alloc] init];
    self.navigationItem.title = @"Aircraft";
    [super viewDidLoad];
}

- (void)dealloc{
    [_jet release];
    [super dealloc];
}

- (void)showPilotViewController{
    PilotViewController *viewController = [[PilotViewController alloc] initWithJet:_jet];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

- (void)showJetTypeViewController{
    JetTypeViewController *viewController = [[JetTypeViewController alloc] initWithJet:_jet];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

- (void)updatePilotOnBoardCell{
    TableSectionContainer *jetSection = [self sectionBySectionIdentifier:jetSectionId];
    AbstractSmartTableViewCell *oldCell = [self cellByCellIdentifier:pilotOnBoardCellId inSection:jetSection];
    
    if([_jet isPilotAllowedOnBoard] && !oldCell){
        AbstractSmartTableViewCell *newCell = [self pilotOnBoardCell];        
        [self insertCell:newCell inSection:jetSection atIndex:[jetSection.cells count]];    
    }
    else if(oldCell){
        [self removeCell:oldCell inSection:jetSection];
    }
}

- (PushTableViewCell *)pilotCell{
    PushTableViewCell *cell = [PushTableViewCell cellWithCellId:pilotCellId];
    
    __block typeof(self) bself = self;
    
    [cell setCalledBlock:^{
        [bself showPilotViewController];
    }];
    
    [self addNotificationObserver:@"PilotNameChanged" object:_jet.pilot usingBlock:^(NSNotification *notification) {
        if([bself.jet.pilot.name length]){
            cell.textLabel.text = bself.jet.pilot.name;
            cell.textLabel.textColor = [UIColor blackColor];            
        }
        else{
            cell.textLabel.text = @"not specified";
            cell.textLabel.textColor = [UIColor grayColor];
        }
        
        [bself updatePilotOnBoardCell];
    } calledBlockImmediately:YES];
    
    return cell;
}

- (PushTableViewCell *)jetTypeCell{
    PushTableViewCell *cell = [PushTableViewCell cellWithCellId:jetTypeCellId];
    
    __block typeof(self) bself = self;
    
    [cell setCalledBlock:^{
        [bself showJetTypeViewController]; 
    }];
    
    [self addNotificationObserver:@"JetTypeChanged" object:_jet usingBlock:^(NSNotification *notification) {
        
    } calledBlockImmediately:YES];
    
    return cell;
}

- (FlexibleEditTableViewCell *)serialNumberCell{
    FlexibleEditTableViewCell *cell = [FlexibleEditTableViewCell cellWithCellId:serialNumberCellId];
    
    cell.keyTextLabel.text = @"S/N";
    
    [cell setShouldChangeCharactersInRangeBlock:^(NSRange range, NSString *string){
        BOOL res = YES; 
        
        NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]"];
        if([string length] && ![regExPredicate evaluateWithObject:string]){
            res = NO;
        }
        
        return res;
    }];
    
    return cell;
}

- (SwitchTableViewCell *)pilotOnBoardCell{
    SwitchTableViewCell *cell = [SwitchTableViewCell cellWithCellId:pilotOnBoardCellId];

    __block typeof(self) bself = self;
    
    cell.textLabel.text = @"Pilot on board";
    
    [cell setCalledBlock:^{
        bself.jet.isPilotOnBoard = !bself.jet.isPilotOnBoard;
    }];
    
    [self addNotificationObserver:@"JetPilotOnBoardChanged" object:_jet usingBlock:^(NSNotification *notification) {
        [cell setChecked:bself.jet.isPilotOnBoard];
    } calledBlockImmediately:YES];
    
    return cell;
}

- (UIView *)pilotFooterView{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] autorelease];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 20)];
    [label setFont:[UIFont systemFontOfSize:15]];
    [label setTextColor:[UIColor redColor]];
    [label setText:@"Pilot must have a name!"];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor clearColor]];
    [label setBackgroundColor:[UIColor clearColor]];    
    [label release];
    return view;
}

- (TableSectionContainer *)pilotSection{
    TableSectionContainer *section = [TableSectionContainer sectionWithSectionId:pilotSectionId];
    
    [section setHeaderTitle:@"Pilot"];    
    [section.cells addObject:[self pilotCell]];
    
    UIView *footerView = [self pilotFooterView];
    [section setFooterView:footerView];
    [section setFooterHeight:footerView.frame.size.height];
    
    return section;
}

- (TableSectionContainer *)jetSection{
    TableSectionContainer *section = [TableSectionContainer sectionWithSectionId:jetSectionId];

    [section setHeaderTitle:@"Aircraft"];    
    [section.cells addObject:[self jetTypeCell]];
    [section.cells addObject:[self serialNumberCell]];
    
    return section;    
}

- (void)updateSections{
    [super updateSections];
    
    [self.sections addObject:[self pilotSection]];
    [self.sections addObject:[self jetSection]];
    
    [self.tableView reloadData];
}

@end
