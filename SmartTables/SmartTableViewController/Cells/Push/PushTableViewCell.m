//
//  PushTableViewCell.m
//
//  Created by Alexey Patosin (alexey@patosin.ru) on 11/24/11.
//

#import "PushTableViewCell.h"

@implementation PushTableViewCell

- (void)initComponents{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.textLabel.textColor = [UIColor blackColor];
}

@end
