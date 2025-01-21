//
//  InstruccionesContenido.h
//  La Huerta
//
//  Created by Daniel on 12/03/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstruccionesContenido : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate> {
    IBOutlet UITableView *tabla_v2;
    IBOutlet UILabel *label_instruccion;
    IBOutlet UITextView * descrip_l;
    NSDictionary *Instruc;
}

@property (strong, nonatomic) NSMutableArray *AddList;
-(IBAction)regresar:(id)sender;


@end
