//
//  ListaArticulosViewController.h
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 21/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgregaArticulosViewController.h"

@interface ListaArticulosViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, AgregaArticulosViewControllerDelegate> {
    IBOutlet UITableView *tabla;
}

-(void)fijaIdLista:(NSString *)i;
-(IBAction)regresar:(id)sender;
-(IBAction)Limpiar:(id)sender;
-(IBAction)agregarArticulos:(id)sender;

@end
