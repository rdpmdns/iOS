//
//  NewComent.m
//  La Huerta
//
//  Created by Daniel on 19/03/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "NewComent.h"
#import "AppDelegate.h"
#import "Constantes.h"
#import "Util.h"




@interface NewComent (){
    NSString * id_Receta;
}

@end

@implementation NewComent
@synthesize N_comentario,fondo_c;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    Agente_row = [AppDelegate sharedAppDelegate].compartido;
//    id_cliente = [Agente_row objectForKey:@"visitaCliente"];
    
    N_comentario.delegate = self;
	// Do any additional setup after loading the view.
}


-(BOOL)textViewdShouldReturn:(UITextView *)textField
{
    [N_comentario resignFirstResponder];
    
    [UIView beginAnimations:@"BajandoFondo" context:nil];
    [UIView setAnimationDuration:0.3];
    [fondo_c setFrame:(CGRect){0, 0, fondo_c.frame.size.width, fondo_c.frame.size.height}];
    [UIView commitAnimations];
    
    if (textField==N_comentario) {
        [self send_comentario];
    }
    
    return YES;
    
    
}


-(IBAction)send_comentario{
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *IdAgente = [defaults stringForKey:@"log_ref"];
//    
//    
//    NSString *sUrl = [NSString stringWithFormat:@"%@%@/%@/%@", SERVIDOR, AddNota, id_cliente, IdAgente];
//    
//    NSURL *url = [NSURL URLWithString:sUrl];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"POST"];
//    
//    
//    NSString * p = [NSString stringWithFormat:@"nota=%@",N_nota.text];
//    
//    NSLog(@"Cadena Reg:%@", p);
//    
//    NSString *postLength = [NSString stringWithFormat:@"%d", [p length]];
//    
//    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
//    NSData *postBody = [p dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    [request setHTTPBody:postBody];
//    //
//    NSURLResponse *response = NULL;
//    
//    NSError *requestError = NULL;
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
//    // begin**
//    //    end
//    
//    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//    
//    if([responseString isEqualToString:@"-1"]){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Hay conexion a Internet o no es posible añadir la nota." message:@"Revise su conexión a internet." delegate:nil cancelButtonTitle:@"Cerrar" otherButtonTitles: nil];
//        [alert show];
//    }
//    else
//        
//        [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [N_comentario resignFirstResponder];
    //
    [UIView beginAnimations:@"BajandoFondo" context:nil];
    [UIView setAnimationDuration:0.3];
    [fondo_c setFrame:(CGRect){0, 0, fondo_c.frame.size.width, fondo_c.frame.size.height}];
    
    [UIView commitAnimations];
    
    
}


/*
 - (void)textViewDidBeginEditing:(UITextView *)textField{
 //    if ( textField == N_Tip) {
 [UIView beginAnimations:@"SubiendoFondo" context:nil];
 [UIView setAnimationDuration:0.3];
 [fondo_ntip setFrame:(CGRect){0,-140,  fondo_ntip.frame.size.width, fondo_ntip.frame.size.height}];
 [UIView commitAnimations];
 //    }
 
 }
 
 - (BOOL)textViewShouldEndEditing:(UITextView *)textView
 {
 return YES;
 }
 */


-(IBAction)regresar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end