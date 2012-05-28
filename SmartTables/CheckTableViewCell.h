//
//  CheckTableViewCell.h
//
//  Created by Alexey Patosin on 11/24/11.
//

#import <UIKit/UIKit.h>
#import "AbstractStateTableViewCell.h"

@interface CheckTableViewCell : AbstractStateTableViewCell{
    BOOL checked;
}

@property(nonatomic, assign) BOOL checked;

- (void) updateCell;

@end
