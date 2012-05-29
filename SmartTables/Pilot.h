//
//  Pilot.h
//  SmartTables
//
//  Created by Alexey Patosin on 5/28/12.
//

#import <Foundation/Foundation.h>

@interface Pilot : NSObject{
    NSString *_name;
}

@property(nonatomic, retain) NSString *name;

- (BOOL)isSpecified;

@end
