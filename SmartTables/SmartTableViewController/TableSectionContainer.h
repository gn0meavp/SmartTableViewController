//
//  TableSectionContainer.m
//
//  Created by Alexey Patosin on 24/11/11.
//

#import <Foundation/Foundation.h>
@class AbstractSmartTableViewCell;

@interface TableSectionContainer : NSObject{
    NSMutableArray *cells;
    int headerHeight;
    int footerHeight;
    NSString *headerTitle;
    NSString *footerTitle;
    UIView *headerView;
    UIView *footerView;
    NSString *sectionIdentifier;
}

@property(nonatomic, retain) NSMutableArray *cells;
@property(nonatomic, assign) int headerHeight;
@property(nonatomic, assign) int footerHeight;
@property(nonatomic, retain) NSString *headerTitle;
@property(nonatomic, retain) NSString *footerTitle;
@property(nonatomic, retain) UIView *headerView;
@property(nonatomic, retain) UIView *footerView;
@property(nonatomic, retain) NSString *sectionIdentifier;

- (id) initWithSectionIdentifier:(NSString*)identifier;
+ (TableSectionContainer *)sectionWithSectionId:(NSString *)identifier;
+ (TableSectionContainer *)emptySectionContainerWithSectionIdentifier:(NSString*)identifier;
- (AbstractSmartTableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath;
@end
