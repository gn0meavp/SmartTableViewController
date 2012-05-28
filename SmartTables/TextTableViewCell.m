//
//  TextTableViewCell.m
//
//  Created by Alexey Patosin on 29.11.11.
//

#import "TextTableViewCell.h"

@interface TextTableViewCell (Private)
- (void) throwIncorrectUsageException;
@end

@implementation TextTableViewCell

//TextTableViewCell cannot have any call object property!
- (NSString *)incorrectUsageExceptionReason{
    return @"TextTableViewCell cannot have any call object property by default";
}

- (void) setCalledBlock:(void (^)(void))calledBlock{
    [self throwIncorrectUsageException];
}

- (void) setViewControllerNameForPush:(NSString *)viewControllerNameForPush{
    [self throwIncorrectUsageException];    
}

- (void) setObject1ToAction:(id)object1ToAction{
    [self throwIncorrectUsageException];    
}

- (void) setObject2ToAction:(id)object2ToAction{
    [self throwIncorrectUsageException];    
}

- (void) setDelegate:(id)delegate{
    [self throwIncorrectUsageException];    
}

@end
