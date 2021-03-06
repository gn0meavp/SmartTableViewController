//
//  Jet.h
//  SmartTables
//
//  Created by Alexey Patosin (alexey@patosin.ru) on 5/28/12.
//

#import <Foundation/Foundation.h>
#import "Pilot.h"

typedef enum{
    JetTypeNotSpecified = 0,
    JetTypeMig29 = 1,
    JetTypeMig31 = 2,
    JetTypeSu27 = 3,
    JetTypeSu24M = 4,
    JetTypeSu25 = 5,
    JetTypeSu30 = 6,
    JetTypeTu22M3 = 7
} JetType;

@interface Jet : NSObject{
    JetType _type;
    NSString *_serialNumber;
    BOOL _isPilotOnBoard;
    Pilot *_pilot;
}

@property(nonatomic, assign) JetType type;
@property(nonatomic, retain) NSString *serialNumber;
@property(nonatomic, assign) BOOL isPilotOnBoard;
@property(nonatomic, retain) Pilot *pilot;

- (BOOL)isPilotAllowedOnBoard;
- (NSString *)jetTypeDesc;
- (NSString *)jetTypeDescForType:(JetType)type;
- (NSString *)isPilotOnBoardDesc;
@end
