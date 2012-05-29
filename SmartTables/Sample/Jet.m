//
//  Jet.m
//
//  Created by Alexey Patosin (alexey@patosin.ru) on 5/28/12.
//

#import "Jet.h"

@implementation Jet
//@synthesize type, isPilotOnBoard, serialNumber;
@synthesize pilot = _pilot;

- (id)init{
    if(self = [super init]){
        _pilot = [[Pilot alloc] init];
    }
    return self;
}

- (void)setType:(JetType)type{
    if(_type != type){
        _type = type;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"JetTypeChanged" object:self];
    }
}

- (JetType)type{
    return _type;
}

- (void)setIsPilotOnBoard:(BOOL)isPilotOnBoard{
    if(_isPilotOnBoard != isPilotOnBoard){
        _isPilotOnBoard = isPilotOnBoard;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"JetPilotOnBoardChanged" object:self];
    }
}

- (BOOL)isPilotOnBoard{
    return _isPilotOnBoard;
}

- (void)setSerialNumber:(NSString *)serialNumber{
    if(_serialNumber != serialNumber){
        [_serialNumber release];
        _serialNumber = [serialNumber retain];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"JetSerialNumberChanged" object:self];
    }
}

- (NSString *)serialNumber{
    return _serialNumber;
}

- (void)dealloc{
    [_pilot release];
    [_serialNumber release];
    
    [super dealloc];
}


- (BOOL)isPilotAllowedOnBoard{
    return [_pilot isSpecified];
}

- (NSString *)jetTypeDescForType:(JetType)type{
    switch (type) {
        case JetTypeMig29:
            return @"MiG-29";
        case JetTypeMig31:
            return @"MiG-31";
        case JetTypeSu27:
            return @"Su-27";
        case JetTypeSu24M:
            return @"Su-24M";
        case JetTypeSu25:
            return @"Su-24";
        case JetTypeSu30:
            return @"Su-30";
        case JetTypeTu22M3:
            return @"Tu22-M3";
        default:
            return @"not specified";
    }
}

- (NSString *)jetTypeDesc{
    return [self jetTypeDescForType:_type];
}

- (NSString *)isPilotOnBoardDesc{
    return _isPilotOnBoard ? @"YES" : @"NO";
}

@end
