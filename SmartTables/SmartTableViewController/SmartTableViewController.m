//
//  SmartTableViewController.m
//
//  Created by Alexey Patosin on 24/11/11.
//

#import "SmartTableViewController.h"

@interface SmartTableViewController (Private)
- (void) removeNotificationObservers;
@end

@implementation SmartTableViewController
@synthesize sections;

- (id) addNotificationObserver:(NSString *)notificationName object:(id)object usingBlock:(void(^)(NSNotification *notification))block calledBlockImmediately:(BOOL)calledBlockImmediately{
    
    if(!_notifications){
        _notifications = [[NSMutableDictionary alloc] init];
    }
    
    //storage all previous observers and remove previous for preventing using 2 observers for the same notification
    
    //remove prev observer for dictionary
    id prevObserver = [_notifications objectForKey:notificationName];
    if(prevObserver){
        [[NSNotificationCenter defaultCenter] removeObserver:prevObserver];
    }
    [_notifications removeObjectForKey:notificationName];
    
    //add new observer to dictionary
    id observer = [[NSNotificationCenter defaultCenter] addObserverForName:notificationName object:object queue:[NSOperationQueue mainQueue] usingBlock:block];
    [_notifications setObject:observer forKey:notificationName];
    
    if(calledBlockImmediately){
        block(nil);
    }
    
    return observer;
}

- (void) removeNotificationObservers{
    [_notifications enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [[NSNotificationCenter defaultCenter] removeObserver:obj];
    }];
    [_notifications removeAllObjects];
}

- (void) dealloc{   
    [self removeNotificationObservers];
    [_notifications release];
    [sections release];
    
    [super dealloc];
}

#pragma mark - Lifecycle methods

- (void) viewDidLoad{
    [super viewDidLoad];
    
    if (self.tableView.style == UITableViewStyleGrouped) {
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    }    
    
    sections = [[NSMutableArray alloc] init];
    
    [self updateSections];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - methods for modifying sections and cells

- (void) updateSections{
    [sections removeAllObjects];
    
    //implement other logic in child classes
}

- (void) replaceSection:(TableSectionContainer *)section withSection:(TableSectionContainer *)newSection{
    int sectionIndex = [self sectionIndexByObject:section];
    
    if(sectionIndex >= 0){
        [self.sections replaceObjectAtIndex:sectionIndex withObject:newSection];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:sectionIndex];
        
        [self.tableView beginUpdates];            
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];    
        [self.tableView endUpdates];                        
    }
}

- (void) replaceCell:(AbstractSmartTableViewCell *)cell inSection:(TableSectionContainer *)section withCell:(AbstractSmartTableViewCell *)newCell{
    int cellIndex = [self cellIndexByObject:cell inSection:section];
    
    if(cellIndex >= 0){
        int sectionIndex = [self sectionIndexByObject:section];
        
        [section.cells replaceObjectAtIndex:cellIndex withObject:newCell];
        NSArray *indexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:cellIndex inSection:sectionIndex]];
        
        [self.tableView beginUpdates];                    
        [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];                        
    }
}

- (void) insertSection:(TableSectionContainer *)section atIndex:(int)sectionIndex{
    //if section is out of the array, put it at the end of it
    if(sectionIndex > [self.sections count]){
        sectionIndex = [self.sections count];
    }
    
    [self.sections insertObject:section atIndex:sectionIndex];
    
    [self.tableView beginUpdates];            
    [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];                    
}

- (void) removeSection:(TableSectionContainer *)section{
    int sectionIndex = [self sectionIndexByObject:section];
    
    if(sectionIndex>=0){
        [self.sections removeObjectAtIndex:sectionIndex];
        
        [self.tableView beginUpdates];        
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];                
    }
}

- (void) insertCell:(AbstractSmartTableViewCell *)cell inSection:(TableSectionContainer *)section atIndex:(int)cellIndex{
    int sectionIndex = [self sectionIndexByObject:section];
    
    if(sectionIndex>=0){
        //if cell is out of the array, put it at the end of it        
        if(cellIndex > [section.cells count]){
            cellIndex = [section.cells count];
        }
                
        [section.cells insertObject:cell atIndex:cellIndex];
        NSArray *indexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:cellIndex inSection:sectionIndex]];
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];    
    }
}

- (void) insertCells:(NSArray *)cells inSection:(TableSectionContainer *)section atIndex:(int)initialCellIndex{
    int sectionIndex = [self sectionIndexByObject:section];
    
    if(sectionIndex>=0){
        //if cells are out of the array, put them at the end of it        
        if(initialCellIndex > [section.cells count]){
            initialCellIndex = [section.cells count];
        }
        
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        
        for(int i=0;i<[cells count];i++){
            int cellIndex = initialCellIndex+i;
            AbstractSmartTableViewCell *cell = [cells objectAtIndex:i];
            [section.cells insertObject:cell atIndex:cellIndex];
            [indexPaths addObject:[NSIndexPath indexPathForRow:cellIndex inSection:sectionIndex]];
        }
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
        
        [indexPaths release];
    }
}

- (void) removeCell:(AbstractSmartTableViewCell *)cell inSection:(TableSectionContainer *)section{
    if(!cell || !section){
        return;
    }
    
    int sectionIndex = [self sectionIndexByObject:section];
    int cellIndex = [self cellIndexByObject:cell inSection:section];
    
    if(sectionIndex>=0 && cellIndex >= 0){
        [section.cells removeObject:cell];
        NSArray *indexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:cellIndex inSection:sectionIndex]];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }
}

- (void)replaceSectionsWithArrayOfSections:(NSArray *)sectionsToShow {
    if (![sectionsToShow lastObject]) {
        [sections removeAllObjects];
        return;
    }
    
    if (![sections lastObject]) {
        [sections addObjectsFromArray:sectionsToShow];
        return;
    }
    
    if (sections != sectionsToShow) {
        int numberOfSections = [sections count];
        int numberOfSectionsToShow = [sectionsToShow count];
        int numberOfSectionsToReplace = (numberOfSections <= numberOfSectionsToShow) ? numberOfSections : numberOfSectionsToShow;
        
        for (int i = 0; i < numberOfSectionsToReplace; i++) {
            [self replaceSection:[sections objectAtIndex:i] withSection:[sectionsToShow objectAtIndex:i]];
        }
        
        if (numberOfSectionsToShow > numberOfSections) {
            for (int i = numberOfSections; i < numberOfSectionsToShow; i++) {
                [self insertSection:[sectionsToShow objectAtIndex:i] atIndex:i];
            }
        }
        
        if (numberOfSections > numberOfSectionsToShow) {
            for (int i = numberOfSections - 1; i > numberOfSectionsToShow - 1; i--) {
                [self removeSection:[sections objectAtIndex:i]];
            }
        }
        
    }
}


#pragma mark - methods for layer between TableView and DataSource/Delegate

- (int)sectionIndexByObject:(TableSectionContainer *)section{
    __block int sectionIndex = -1;
    [self.sections enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if(obj == section){
            sectionIndex = idx;
            *stop = YES;
        }
    }];
    
    return sectionIndex;
}

- (int)cellIndexByObject:(AbstractSmartTableViewCell *)cell inSection:(TableSectionContainer *)section{
    __block int cellIndex = -1;
    [section.cells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if(obj == cell){
            cellIndex = idx;
            *stop = YES;
        }
    }];
    
    return cellIndex;
}

- (TableSectionContainer *) sectionAtIndexPath:(NSIndexPath *)indexPath{
    TableSectionContainer *section = nil;
    if([self.sections count] > indexPath.section){
        section = [self.sections objectAtIndex:indexPath.section];
    }
    return section;
}

- (AbstractSmartTableViewCell *) cellAtIndexPath:(NSIndexPath *)indexPath{
    TableSectionContainer *sectionContainer = [self sectionAtIndexPath:indexPath];
    return [sectionContainer cellAtIndexPath:indexPath];
}


- (AbstractSmartTableViewCell *) cellByCellIdentifier:(NSString *)cellIdentifier inSection:(TableSectionContainer *)section{
    __block AbstractSmartTableViewCell *cell = nil;

    [section.cells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        AbstractSmartTableViewCell *curCell = (AbstractSmartTableViewCell *)obj;
        if([curCell.reuseIdentifier isEqualToString:cellIdentifier]){
            *stop = YES;
            
            cell = curCell;
        }
    }];
    
    return cell;
}

- (TableSectionContainer *) sectionBySectionIdentifier:(NSString *)sectionIdentifier{
    __block TableSectionContainer *section = nil;
    [self.sections enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([((TableSectionContainer *)obj).sectionIdentifier isEqualToString:sectionIdentifier]){
            section = (TableSectionContainer *)obj;
            *stop = YES;
        }
    }];
    
    return section;
}

#pragma Supplementary methods for EditTableViewCell interaction

- (BOOL) findNextResponderByTag:(int)tag {
    BOOL res = NO;
    NSArray* rows = [self.tableView indexPathsForVisibleRows];
    
    for (int i=0; i<[rows count]; i++) {
        NSIndexPath* index = [rows objectAtIndex:i];
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:index];
        if ([cell isKindOfClass:[EditTableViewCell class]]) {
            EditTableViewCell* cell2 = (EditTableViewCell*)cell;
            if (cell2 != nil) {
                if (cell2.valueTextField.tag == tag) {
                    [cell2.valueTextField becomeFirstResponder];
//                    NSLog(@"Scroll cell");
                    [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
                    res = YES;
                    break;
                } 
            }
        } 
    }
    return res;
}

- (void) selectParentCellByTag:(int)tag {
    NSArray* rows = [self.tableView indexPathsForVisibleRows];
    
    for (int i=0; i<[rows count]; i++) {
        NSIndexPath* index = [rows objectAtIndex:i];
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:index];
        if ([cell isKindOfClass:[EditTableViewCell class]]) {
            EditTableViewCell* cell2 = (EditTableViewCell*)cell;
            if (cell2 != nil) {
                if (cell2.valueTextField.tag == tag) {
//                    NSLog(@"Select cell");
                    [self.tableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionTop];
                    break;
                } 
            }
        } 
    }  
}

- (void) setCellColor:(UIColor *)color forTag:(int)tag {
    UIView *cell = [self.tableView viewWithTag:tag];
    if([cell isKindOfClass:[AbstractSmartTableViewCell class]]){
        cell.backgroundColor = color;
    }
}

#pragma mark - didSelectRow methods for different kind of cells

- (void) pushCellClicked:(PushTableViewCell *)pushCell{
    UIViewController *viewController = [pushCell viewControllerForPush];
    if(viewController){
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if(pushCell.calledBlock){
        pushCell.calledBlock();
    }
    
    [pushCell invokeDelegateMethod]; 
}

- (void) checkCellClicked:(CheckTableViewCell *)checkCell{
    [checkCell stateChanged:self];
}

- (void) switchCellClicked:(SwitchTableViewCell *)switchCell{
    [switchCell stateChanged:self];    
}

- (void) editCellClicked:(EditTableViewCell *)editCell{
    [editCell setFocusToTextField];
}

- (void) textCellClicked:(TextTableViewCell *)textCell{
    //just do nothing
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableSectionContainer *sectionContainer = [sections objectAtIndex:indexPath.section];
    AbstractSmartTableViewCell *cell = [sectionContainer.cells objectAtIndex:indexPath.row];
    
    return cell.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    TableSectionContainer *sectionContainer = [sections objectAtIndex:section];
    return sectionContainer.headerHeight;    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    TableSectionContainer *sectionContainer = [sections objectAtIndex:section]; 
    return sectionContainer.footerHeight;    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AbstractSmartTableViewCell *cell = [self cellAtIndexPath:indexPath];
        
    if(!cell){
        //looks like cell was removed already (for example from calledBlock of that cell)
        return;
    }
    
    if([cell isKindOfClass:[PushTableViewCell class]]){
        [self pushCellClicked:(PushTableViewCell *)cell];
    }
    else if([cell isKindOfClass:[CheckTableViewCell class]]){
        [self checkCellClicked:(CheckTableViewCell *)cell];
    }
    else if([cell isKindOfClass:[SwitchTableViewCell class]]){
        [self switchCellClicked:(SwitchTableViewCell *)cell];
    }
    else if([cell isKindOfClass:[EditTableViewCell class]]){
        [self editCellClicked:(EditTableViewCell *)cell];
    }
    else if([cell isKindOfClass:[TextTableViewCell class]]){
        [self textCellClicked:(TextTableViewCell *)cell];
    }
    else{
        NSException *exception = [NSException exceptionWithName:@"IncorrectTypeException" reason:@"Unknown cell type in TableItemsContainer" userInfo:[NSDictionary dictionaryWithObject:cell forKey:@"Object"]];
        @throw exception;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TableSectionContainer *sectionContainer = [self.sections objectAtIndex:section];
    return sectionContainer.headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    TableSectionContainer *sectionContainer = [self.sections objectAtIndex:section];
    return sectionContainer.footerView;
}

#pragma mark - UITableViewDatasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[sections objectAtIndex:section] cells] count];    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AbstractSmartTableViewCell *cell = [self cellAtIndexPath:indexPath];
    return cell;    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [sections count];    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    TableSectionContainer *sectionContainer = [self.sections objectAtIndex:section];
    return sectionContainer.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    TableSectionContainer *sectionContainer = [self.sections objectAtIndex:section];
    return sectionContainer.footerTitle;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AbstractSmartTableViewCell* cell =  [self cellAtIndexPath:indexPath];
    return cell.editingStyle; 
}

@end
