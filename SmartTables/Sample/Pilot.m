//
//  Pilot.m
//
//  Created by Alexey Patosin (alexey@patosin.ru) on 5/28/12.
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
