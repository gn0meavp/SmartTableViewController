//
//  PilotViewController.h
//  SmartTables
//
//  Created by Alexey Patosin (alexey@patosin.ru) on 5/28/12.
//

#import <Foundation/Foundation.h>
#import "SmartTableViewController.h"
#import "Jet.h"
#import "Pilot.h"

@interface PilotViewController : SmartTableViewController{
    Jet *_jet;
}

- (id)initWithJet:(Jet *)jet;

@end
