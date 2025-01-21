//
//  ListaIngredientes.h
//  La Huerta
//
//  Created by Daniel on 24/03/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListaIngredientes : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate> {

    IBOutlet UITableView *tabla_lista;
    IBOutlet UILabel *name_ing;
    
    
}

@property (strong, nonatomic) NSMutableArray *ingrediente_add;
@property (strong, nonatomic) IBOutlet UIButton * check;

-(IBAction)ingredient_select:(id)sender;
-(IBAction)Limpiar:(id)sender;

@end
