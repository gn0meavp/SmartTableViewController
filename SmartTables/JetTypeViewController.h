//
//  JetTypeViewController.h
//  SmartTables
//
//  Created by Alexey Patosin on 5/28/12.
//  Copyright (c) 2012 Yota Labs LLC, Russia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmartTableViewController.h"
#import "Jet.h"

@interface JetTypeViewController : SmartTableViewController{
    Jet *_jet;
}

- (id)initWithJet:(Jet *)jet;

@end
