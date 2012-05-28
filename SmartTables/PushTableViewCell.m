//
//  PushTableViewCell.m
//
//  Created by Alexey Patosin on 11/24/11.
//

#import "PushTableViewCell.h"

@implementation PushTableViewCell

- (void)initComponents{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.textLabel.textColor = [UIColor blackColor];
}

@end
