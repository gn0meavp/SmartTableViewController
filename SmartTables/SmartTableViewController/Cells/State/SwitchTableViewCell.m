//
//  SwitchTableViewCell.m
//
//  Created by Alexey Patosin on 11/24/11.
//

#import "SwitchTableViewCell.h"

@implementation SwitchTableViewCell
@synthesize switchButton = _switchButton;
- (void)initComponents {
    _switchButton = [[UISwitch alloc] initWithFrame:CGRectZero];
    [_switchButton addTarget:self action:@selector(stateChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.textLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;        
    [self setAccessoryView:_switchButton];
}

- (BOOL) stateStatus{
    return _switchButton.isOn;
}

- (void) setChecked:(BOOL)newStatus{
    [_switchButton setOn:newStatus];
}

- (void)dealloc
{
    [_switchButton release];    
    [super dealloc];
}
@end
