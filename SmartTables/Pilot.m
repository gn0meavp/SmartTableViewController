//
//  Pilot.m
//
//  Created by Alexey Patosin on 5/28/12.
//

#import "Pilot.h"

@implementation Pilot

- (void)setName:(NSString *)name{
    if(_name != name){
        _name = [name retain];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PilotNameChanged" object:self];
    }
}

- (NSString *)name{
    return _name;
}


- (BOOL)isSpecified{
    return [self.name length];
}

@end
