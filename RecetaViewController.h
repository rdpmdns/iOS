//
//  RecetaViewController.h
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 23/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecetaViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    IBOutlet UITableView *tabla;
    IBOutlet UITextField *busqueda;
    IBOutlet UILabel *labelTitulo;
}

-(IBAction)regresar:(id)sender;
-(void)fijaTituloCategoria:(NSString *)c idReceta:(NSString *)i;

@end
