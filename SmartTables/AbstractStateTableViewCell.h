//
//  AbstractSmartTableViewCell.h
//
//  Created by Alexey Patosin on 03.12.11.
//

#import "AbstractSmartTableViewCell.h"

@interface AbstractStateTableViewCell : AbstractSmartTableViewCell

- (BOOL) stateStatus;
- (void) stateChanged:(id)sender;
@end