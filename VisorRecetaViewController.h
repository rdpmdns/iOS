//
//  VisorRecetaViewController.h
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 23/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Receta.h"

@interface VisorRecetaViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate> {
    
    IBOutlet UITableView *tabla_comentarios;
    IBOutlet UITableView *tabla_ingredientes;
    
    IBOutlet UILabel *labelNobreCategoria;
    IBOutlet UILabel *labelNombreReceta;
    IBOutlet UILabel *labePorciones;
    IBOutlet UILabel *labelMinutos;
    IBOutlet UIImageView *imagenReceta;
    
    IBOutlet UIView *viewPasoPaso;
    IBOutlet UIView *viewIngredientes;
    IBOutlet UIView *viewComentarios;
    
    
    IBOutlet UIButton *btnPasoPaso;
    IBOutlet UIButton *btnIngredientes;
    IBOutlet UIButton *btnComentarios;
    IBOutlet UILabel *labelPasoPaso;
    IBOutlet UILabel *labelIngredientes;
    IBOutlet UILabel *labelComentarios;
    
    
//    IBOutlet UITextView *Ingredientes_json;
//    IBOutlet UITextView *pasos_json;
//    IBOutlet UITextField *addComent;
    
    IBOutlet UIButton *one;
    IBOutlet UIButton *two;
    IBOutlet UIButton *three;
    IBOutlet UIButton *four;
    IBOutlet UIButton *five;
   
    
//    IBOutlet UILabel *ingrediente_here;
    //IBOutlet UIButton *ingredient_here;
    
    IBOutlet UITextView *Pasos_add;
    
    
    
}


@property (strong, nonatomic) NSMutableArray *comentarioList;
@property (strong, nonatomic) NSMutableArray *ingredienteList;
@property (strong, nonatomic) NSMutableArray *temp_array;


@property (retain, nonatomic) IBOutlet UIView  *fondo_comentarios;
@property (retain, nonatomic) IBOutlet UITextField  *addComent;
@property (retain, nonatomic) IBOutlet UIButton * ing_here;

-(void)fiaReceta:(Receta *)r nombreCategoria:(NSString *)nombre;
-(IBAction)clickVota:(id)sender;
-(IBAction)clickComparte:(id)sender;
-(IBAction)pasoPaso:(id)sender;
-(IBAction)ingredientes:(id)sender;
-(IBAction)comentarios:(id)sender;
-(IBAction)regresar:(id)sender;

-(IBAction)uploadComent;

-(IBAction)add_favoritas:(id)sender;


-(IBAction)uno:(id)sender;
-(IBAction)dos:(id)sender;
-(IBAction)tres:(id)sender;
-(IBAction)cuatro:(id)sender;
-(IBAction)cinco:(id)sender;

//uibutton
-(IBAction)ingredient_select:(id)sender;


-(IBAction)add_lista_super;


@end
