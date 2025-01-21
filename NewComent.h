//
//  NewComent.h
//  La Huerta
//
//  Created by Daniel on 19/03/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewComent : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (retain, nonatomic) IBOutlet UITextView  *N_comentario;
@property (retain, nonatomic) IBOutlet UIView  *fondo_c;

-(IBAction) send_comentario;
-(IBAction)regresar:(id)sender;

@end
