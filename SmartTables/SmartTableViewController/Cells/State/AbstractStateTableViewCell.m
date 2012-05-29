//
//  AbstractStateTableViewCell.m
//
//  Created by Alexey Patosin (alexey@patosin.ru) on 03.12.11.
//

#import "AbstractStateTableViewCell.h"

@implementation AbstractStateTableViewCell

- (BOOL) stateStatus{
    NSException *exception = [NSException exceptionWithName:@"AbstractMethodCalled" reason:@"stateStatus method shall be implemented in child class" userInfo:[NSDictionary dictionaryWithObject:self forKey:@"object"]];
    
    @throw exception;
}

- (void)stateChanged:(id)sender{
    if(calledBlock){
        calledBlock();
    }
    
    [self invokeDelegateMethod];
    
    NSString *notificationName = [NSString stringWithFormat:@"NotificationStateTableViewCellId_%@", self.reuseIdentifier];
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self userInfo:nil];
}


@end
