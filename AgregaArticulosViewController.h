//
//  AgregaArticulosViewController.h
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 21/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AgregaArticulosViewControllerDelegate;

@interface AgregaArticulosViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    IBOutlet UITableView *tabla;
    id  delegate;
}

@property (nonatomic, retain) id  delegate;
-(IBAction)regresar:(id)sender;
-(IBAction)nuevoProducto:(id)sender;
-(IBAction)terminaSeleccion:(id)sender;
-(void)fijaIdLista:(NSString *)i;

@end

@protocol AgregaArticulosViewControllerDelegate
-(void)regresaArticulos:(NSMutableArray *)articulos parent:(AgregaArticulosViewController *)parent;
@end