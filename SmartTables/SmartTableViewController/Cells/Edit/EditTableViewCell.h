//
//  EditTableViewCell.h
//
//  Created by Alexey Patosin (alexey@patosin.ru) on 21.09.11.
//

#import <UIKit/UIKit.h>
#import "AbstractSmartTableViewCell.h"

@interface EditTableViewCell : AbstractSmartTableViewCell<UITextFieldDelegate> { 
    UILabel* _keyTextLabel;
    UITextField* _valueTextField;
}

@property (nonatomic, retain) UILabel *keyTextLabel;
@property (nonatomic, retain) UITextField *valueTextField;

- (void) setFocusToTextField;


@end
