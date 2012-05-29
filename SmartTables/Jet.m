//
//  Jet.m
//
//  Created by Alexey Patosin on 5/28/12.
//

#import "Jet.h"

@implementation Jet
@synthesize type, isPilotOnBoard, serialNumber, pilot;

- (id)init{
    if(self = [super init]){
        pilot = [[Pilot alloc] init];
    }
    return self;
}

- (void)dealloc{
    [pilot release];
    [serialNumber release];
    
    [super dealloc];
}

- (BOOL)isPilotAllowedOnBoard{
    return [pilot isSpecified];
}

@end
