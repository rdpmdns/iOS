//
//  RecetarioViewController.h
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 22/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecetarioViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    IBOutlet UITableView *tabla;
    IBOutlet UITextField *busqueda;
}

-(IBAction)regresar:(id)sender;
-(IBAction)buscar:(id)sender;

@end
