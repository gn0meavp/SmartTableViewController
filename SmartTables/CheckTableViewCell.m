//
//  CheckTableViewCell.m
//
//  Created by Alexey Patosin on 11/24/11.
//

#import "CheckTableViewCell.h"

@implementation CheckTableViewCell
@synthesize checked;

- (void) initComponents{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setAccessoryType:UITableViewCellAccessoryNone];
}

- (void) setChecked:(BOOL)_checked{
    checked = _checked;
    [self updateCell];
}

- (void) updateCell{
    [self updateAccessoryType];
}

- (void) stateChanged:(id)sender{
    checked = !checked;
    
    [self updateCell];
    [super stateChanged:sender];
}

- (BOOL) stateStatus{
    return checked;
}

- (void) updateAccessoryType{
    if(checked){
        [self setAccessoryType:UITableViewCellAccessoryCheckmark];    
    }
    else{
        [self setAccessoryType:UITableViewCellAccessoryNone];
    }    
}

@end
