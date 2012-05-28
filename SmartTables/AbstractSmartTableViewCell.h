//
//  AbstractSmartTableViewCell.h
//
//  Created by Alexey Patosin on 11/24/11.
//

#import <UIKit/UIKit.h>

typedef void(^CalledBlock)(void);

@interface AbstractSmartTableViewCell : UITableViewCell{
    CalledBlock calledBlock;                   //call block when change state
    
    NSString *viewControllerNameForPush;       //push to viewController when click
    
    SEL actionSelector;
    id object1ToAction;
    id object2ToAction;
    id delegate;
    
    NSUInteger rowHeight;
    
    UITableViewCellEditingStyle editingStyle;
}

@property(nonatomic, assign) SEL actionSelector;
@property(nonatomic, retain) id object1ToAction;        //must be not nil
@property(nonatomic, retain) id object2ToAction;        //must be not nil
@property(nonatomic, assign) id delegate;
@property(nonatomic, retain) NSString *viewControllerNameForPush;
@property(readwrite, copy) CalledBlock calledBlock;
@property(nonatomic, assign) NSUInteger rowHeight;
@property(nonatomic, assign) UITableViewCellEditingStyle editingStyle;

- (id)initWithCellIdentifier:(NSString *)cellIdentifier;
- (void) initComponents;
+ (id)cellWithCellId:(NSString*)cellId;

- (UIViewController *)viewControllerForPush;
- (void)invokeDelegateMethod;
- (NSString *)incorrectUsageExceptionReason;
- (void) throwIncorrectUsageException;
- (void)updateAccessoryType;
@end
