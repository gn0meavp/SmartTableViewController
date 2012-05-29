//
//  JetViewController.h
//  SmartTables
//
//  Created by Alexey Patosin (alexey@patosin.ru) on 5/28/12.
//

#import <Foundation/Foundation.h>
#import "SmartTableViewController.h"
#import "Jet.h"

@interface JetViewController : SmartTableViewController{
    Jet *_jet;
}

@property(nonatomic, retain) Jet *jet;

@end
