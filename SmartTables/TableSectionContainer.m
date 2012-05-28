//
//  TableSectionContainer.h
//
//  Created by Alexey Patosin on 24/11/11.
//

#import "TableSectionContainer.h"
#import "AbstractSmartTableViewCell.h"

@implementation TableSectionContainer
@synthesize cells;
@synthesize headerHeight;
@synthesize footerHeight;
@synthesize headerTitle;
@synthesize footerTitle;
@synthesize headerView;
@synthesize footerView;
@synthesize sectionIdentifier;

CGFloat const HEADER_VIEW_HEIGHT = 20.0;
CGFloat const FOOTER_VIEW_HEIGHT = 25.0;

- (id) initWithSectionIdentifier:(NSString*)identifier{
    if(self = [super init]){
        headerHeight = HEADER_VIEW_HEIGHT;
        footerHeight = 0;
        
        headerTitle = nil;
        footerTitle = nil;
        
        headerView = nil;
        footerView = nil;
        
        self.sectionIdentifier = identifier;
        
        cells = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (TableSectionContainer *)sectionWithSectionId:(NSString *)identifier{
    return [[[[self class] alloc] initWithSectionIdentifier:identifier] autorelease];
}

+ (TableSectionContainer *)emptySectionContainerWithSectionIdentifier:(NSString*)identifier{
    TableSectionContainer *emptySectionContainer = [[[TableSectionContainer alloc] initWithSectionIdentifier:identifier] autorelease];
    
    emptySectionContainer.headerHeight = 0;
    emptySectionContainer.footerHeight = 0;
    emptySectionContainer.headerTitle = nil;        
    emptySectionContainer.footerTitle = nil;    
    emptySectionContainer.headerView = nil;
    emptySectionContainer.footerView = nil;
    
    return emptySectionContainer;
}

- (AbstractSmartTableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath{
    AbstractSmartTableViewCell *cell = nil;
    
    if([self.cells count] > indexPath.row){
        cell = [self.cells objectAtIndex:indexPath.row];
    }
    
    return cell;
}

@end
