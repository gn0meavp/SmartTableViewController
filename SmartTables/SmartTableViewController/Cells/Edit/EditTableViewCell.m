//
//  EditTableViewCell.m
//
//  Created by Alexey Patosin (alexey@patosin.ru) on 21.09.11.
//

#import "EditTableViewCell.h"

@implementation EditTableViewCell

@synthesize keyTextLabel=_keyTextLabel, valueTextField=_valueTextField;

- (void)initComponents
{
    // Initialization code
    CGRect frame = CGRectMake(10, 9, 105, 26);
    _keyTextLabel = [[UILabel alloc]initWithFrame:frame];
    _keyTextLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    _keyTextLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_keyTextLabel];
    
    frame.origin.x += 120;
    frame.origin.y += 0;
    frame.size.width += 85;
    _valueTextField = [[UITextField alloc]initWithFrame:frame];
    _valueTextField.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    _valueTextField.textColor = [UIColor darkGrayColor];
    _valueTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _valueTextField.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [_valueTextField setDelegate:self];
    [self.contentView addSubview:_valueTextField];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

//EditTableViewCell cannot have any call object property!
- (NSString *)incorrectUsageExceptionReason{
    return @"EditTableViewCell cannot have viewControllerNameForPush object property by default";
}

- (void) setViewControllerNameForPush:(NSString *)viewControllerNameForPush{
    [self throwIncorrectUsageException];    
}

- (void) setFocusToTextField{
    [_valueTextField resignFirstResponder];
}

- (BOOL) textField:(UITextField *)textField_ shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //to call block with updated string we update textField.string manually
    NSMutableString *newText = [[NSMutableString alloc] initWithString:textField_.text];
    [newText replaceCharactersInRange:range withString:string];
    [_valueTextField setText:newText];
    [newText release];
    
    if(calledBlock){
        calledBlock();
    }
    [self invokeDelegateMethod];
    
    return NO;
}

- (void)dealloc
{
    [_valueTextField release];
    [_keyTextLabel release];
    
    [super dealloc];
}

@end