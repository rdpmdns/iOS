//
//  InstruccionesViewController.h
//  La Huerta
//
//  Created by Daniel on 12/03/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstruccionesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    IBOutlet UITableView *tabla_instrucciones;
    IBOutlet UITextField *busqueda;
}

@property (strong, nonatomic) NSMutableArray *InstruccionesList;


-(IBAction)regresar:(id)sender;
-(IBAction)buscar:(id)sender;
@end
