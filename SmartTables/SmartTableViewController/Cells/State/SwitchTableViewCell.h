//
//  SwitchTableViewCell.h
//
//  Created by Alexey Patosin on 11/24/11.
//

#import <UIKit/UIKit.h>
#import "AbstractStateTableViewCell.h"

@interface SwitchTableViewCell : AbstractStateTableViewCell{
    UISwitch *_switchButton;
}
@property(nonatomic, retain)  UISwitch *switchButton;
- (void) setChecked:(BOOL)newStatus;
@end
