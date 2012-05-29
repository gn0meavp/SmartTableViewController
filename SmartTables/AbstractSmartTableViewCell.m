//
//  AbstractSmartTableViewCell.m
//
//  Created by Alexey Patosin on 11/24/11.
//

#import "AbstractSmartTableViewCell.h"

const float DEFAULT_CELL_HEIGHT = 44;

@interface AbstractSmartTableViewCell(Private)
- (void) initComponents;
- (void) updateAccessoryType;
@end

@implementation AbstractSmartTableViewCell
@synthesize viewControllerNameForPush;
@synthesize actionSelector, object1ToAction, object2ToAction, delegate;
@synthesize rowHeight;
@synthesize editingStyle;

- (id)initWithCellIdentifier:(NSString *)cellIdentifier{
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    return self;
}

+ (id)cellWithCellId:(NSString*)cellId{
    return [[[[self class] alloc] initWithCellIdentifier:cellId] autorelease];
}

- (void)updateAccessoryType{
    if(calledBlock || viewControllerNameForPush || (delegate && actionSelector)){
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        rowHeight = DEFAULT_CELL_HEIGHT;
        [self initComponents];
    }
    return self;
}

- (void) initComponents{
    //child classes could init additional components here
}

- (void)dealloc{
    [viewControllerNameForPush release];    
    
    [super dealloc];
}

#pragma mark - getters and setters

//calledBlock doesn't use @synthesize or @dynamic, because it's atomic property
- (void) setCalledBlock:(CalledBlock)_calledBlock{
    if(calledBlock != _calledBlock){
        [calledBlock release];
        calledBlock = [_calledBlock copy];
        
        [self updateAccessoryType];
    }
}

- (CalledBlock)calledBlock{
    return calledBlock;
}

- (void) setViewControllerNameForPush:(NSString *)_viewControllerNameForPush{
    if(viewControllerNameForPush != _viewControllerNameForPush){
        [viewControllerNameForPush release];
        viewControllerNameForPush = [_viewControllerNameForPush retain];
        
        [self updateAccessoryType];
    }
}

- (void) setActionSelector:(SEL)_actionSelector{
    if(actionSelector != _actionSelector){
        actionSelector = _actionSelector;
        
        [self updateAccessoryType];
    }
}

- (void) setDelegate:(id)_delegate{
    if(delegate != _delegate){
        delegate = _delegate;
        
        [self updateAccessoryType];
    }
}

#pragma mark - exceptions

- (void) throwIncorrectUsageException{
    NSException *exception = [NSException exceptionWithName:@"IncorrectUsageException" reason:[self incorrectUsageExceptionReason] userInfo:[NSDictionary dictionaryWithObject:self forKey:@"Object"]];
    @throw exception;
}

- (NSString *)incorrectUsageExceptionReason{
    return @"Something called wrong in table view cells";
}

#pragma mark - cell actions

- (UIViewController *)viewControllerForPush{
    UIViewController *viewController = nil;
    
    if(viewControllerNameForPush){
        viewController = [[[NSClassFromString(viewControllerNameForPush) alloc] init] autorelease];
    }
    
    return viewController;
}

- (void)invokeDelegateMethod{
    if(delegate){
        if([delegate respondsToSelector:actionSelector]){
            if(object1ToAction){
                if(object2ToAction){
                    [delegate performSelector:actionSelector withObject:object1ToAction withObject:object2ToAction];
                }
                else{
                    [delegate performSelector:actionSelector withObject:object1ToAction];
                }
            }
            else{
                [delegate performSelector:actionSelector];
            }
        }
    }
}

@end
