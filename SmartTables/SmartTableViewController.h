//
//  SmartTableViewController.h
//
//  Created by Alexey Patosin (alexey@patosin.ru) on 24/11/11.
//

#import <Foundation/Foundation.h>
#import "TableSectionContainer.h"

#import "SwitchTableViewCell.h"
#import "CheckTableViewCell.h"
#import "PushTableViewCell.h"
#import "EditTableViewCell.h"
#import "TextTableViewCell.h"
#import "FlexibleEditTableViewCell.h"

@interface SmartTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *sections;
    NSMutableDictionary *_notifications;
}

@property(nonatomic, retain) NSMutableArray *sections;

- (void) updateSections;
- (TableSectionContainer *) sectionAtIndexPath:(NSIndexPath *)indexPath;
- (AbstractSmartTableViewCell *) cellAtIndexPath:(NSIndexPath *)indexPath;
- (AbstractSmartTableViewCell *) cellByCellIdentifier:(NSString *)cellIdentifier inSection:(TableSectionContainer *)section;
- (TableSectionContainer *) sectionBySectionIdentifier:(NSString *)sectionIdentifier;

- (void) pushCellClicked:(PushTableViewCell *)cell;
- (void) checkCellClicked:(CheckTableViewCell *)cell;
- (void) switchCellClicked:(SwitchTableViewCell *)cell;
- (void) textCellClicked:(TextTableViewCell *)cell;
- (void) editCellClicked:(EditTableViewCell *)cell;

- (id) addNotificationObserver:(NSString *)notificationName object:(id)object usingBlock:(void(^)(NSNotification *notification))block calledBlockImmediately:(BOOL)calledBlockImmediately;

- (void) insertSection:(TableSectionContainer *)section atIndex:(int)sectionIndex;
- (void) insertCell:(AbstractSmartTableViewCell *)cell inSection:(TableSectionContainer *)section atIndex:(int)cellIndex;
- (void) insertCells:(NSArray *)cells inSection:(TableSectionContainer *)section atIndex:(int)initialCellIndex;
- (void) removeSection:(TableSectionContainer *)section;
- (void) removeCell:(AbstractSmartTableViewCell *)cell inSection:(TableSectionContainer *)section;
- (void) replaceSection:(TableSectionContainer *)section withSection:(TableSectionContainer *)newSection;
- (void) replaceCell:(AbstractSmartTableViewCell *)cell inSection:(TableSectionContainer *)section withCell:(AbstractSmartTableViewCell *)newCell;
- (void) replaceSectionsWithArrayOfSections:(NSArray *)sectionsToShow;

- (int)sectionIndexByObject:(TableSectionContainer *)section;
- (int)cellIndexByObject:(AbstractSmartTableViewCell *)cell inSection:(TableSectionContainer *)section;

- (BOOL) findNextResponderByTag:(int)tag;
- (void) selectParentCellByTag:(int)tag;
- (void) setCellColor:(UIColor *)color forTag:(int)tag; 

@end
