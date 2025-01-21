//
//  VisorRecetaViewController.m
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 23/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "VisorRecetaViewController.h"
#import "ConexionComentarios.h"
#import "UserLogin.h"
#import "Util.h"
#import "AppDelegate.h"
#import "Productos.h"
#import "NewComent.h"
#import "Constantes.h"
#import "ConexionUsuarios.h"

@interface VisorRecetaViewController () {
    Receta *receta;
    UIView * viewEspera;
    NSString *nombreCategoria;
    UIScrollView *scrollPasos;
    UIScrollView *scrollIngredientes;
    UITableView *tablaComentarios;
    int *x;
    
}


//@property (strong, nonatomic) VisorRecetaViewController *tabla_comentarios;

@end


@implementation VisorRecetaViewController
@synthesize comentarioList, ingredienteList, fondo_comentarios, addComent, ing_here, temp_array;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(IBAction)circles:(id)sender
{

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    addComent.delegate =self;
    x=1;
    labelMinutos.text = [receta dameMinutosReceta];
    labelNobreCategoria.text = nombreCategoria;
    labelNombreReceta.text = [receta dameNombreReceta];
    labePorciones.text = [receta damePorcionReceta];
    
        self.temp_array = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    if ([receta dameImagen] == NULL) {
        imagenReceta.image = [UIImage imageNamed:@"logo.png"];
    } else {
        imagenReceta.image = [receta dameImagen];
    }
    labelPasoPaso.textColor = [UIColor colorWithRed:140.0/255.0 green:202.0/255.0 blue:65.0/255.0 alpha:1];
    [btnComentarios setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btnIngredientes setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    viewComentarios.hidden = YES;
    viewIngredientes.hidden = YES;
    viewPasoPaso.hidden = NO;
    
//    [self creaViewComentarios];
//    [self creaViewIngredientes];
//    [self creaViewPasos];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)ingredient_select:(id)sender{
    UITableViewCell *c;
    c = ((UITableViewCell *)[[[sender superview] superview] superview]);
    NSIndexPath *i = ((NSIndexPath *) [tabla_ingredientes indexPathForCell:c]);
    
//    NSNumber *when = [[NSNumber alloc] initWithInteger:i];
//    esto no funciona
//    int catId = [ ((NSNumber*) [tabla_ingredientes indexPathForCell:c] ) intValue];
//    
//    int xs=[ingredienteList count];
        int j = (int)i;
//    for(int x1=0; x1<=xs; x1++) {
//        if (x1==j) {
//            break;
//        }
//    }

    
//    int j =[self.ingredienteList objectAtIndex:i.row];
    
//    [temp_array objectAtIndex:j] == [NSNumber numberWithBool:NO] ||
    if ( x==1) {
        [sender setImage:[UIImage imageNamed:@"circulo2.png"] forState:normal];
         [[AppDelegate sharedAppDelegate].compartido addObject:[self.ingredienteList objectAtIndex:i.row]];
//        c = ((UITableViewCell *)[[[sender superview] superview] superview]);
//    NSIndexPath *i = ((NSIndexPath *) [tabla_ingredientes indexPathForCell:c]);
//        [temp_array replaceObjectAtIndex:j withObject:[NSNumber numberWithBool:YES]];
        x=2;
        
    }
     else{
        [sender setImage:[UIImage imageNamed:@"circulo1.png"] forState:normal];
                 [[AppDelegate sharedAppDelegate].compartido removeObject:[self.ingredienteList objectAtIndex:i.row]];
//        [temp_array replaceObjectAtIndex:j withObject:[NSNumber numberWithBool:NO]];
         x=1;
    }
    
}



//backing_start
-(IBAction)uno:(id)sender{
    [one setImage:[UIImage imageNamed:@"estrella1.png"] forState:normal];
    [two setImage:[UIImage imageNamed:@"estrella2.png"] forState:normal];
    [three setImage:[UIImage imageNamed:@"estrella2.png"] forState:normal];
    [four setImage:[UIImage imageNamed:@"estrella2.png"] forState:normal];
    [five setImage:[UIImage imageNamed:@"estrella2.png"] forState:normal];
}


-(IBAction)dos:(id)sender{
    [one setImage:[UIImage imageNamed:@"estrella1.png"] forState:normal];
    [two setImage:[UIImage imageNamed:@"estrella1.png"] forState:normal];
    [three setImage:[UIImage imageNamed:@"estrella2.png"] forState:normal];
    [four setImage:[UIImage imageNamed:@"estrella2.png"] forState:normal];
    [five setImage:[UIImage imageNamed:@"estrella2.png"] forState:normal];
}


-(IBAction)tres:(id)sender{
    [one setImage:[UIImage imageNamed:@"estrella1.png"] forState:normal];
    [two setImage:[UIImage imageNamed:@"estrella1.png"] forState:normal];
    [three setImage:[UIImage imageNamed:@"estrella1.png"] forState:normal];
    [four setImage:[UIImage imageNamed:@"estrella2.png"] forState:normal];
    [five setImage:[UIImage imageNamed:@"estrella2.png"] forState:normal];
}

-(IBAction)cuatro:(id)sender{
    [one setImage:[UIImage imageNamed:@"estrella1.png"] forState:normal];
    [two setImage:[UIImage imageNamed:@"estrella1.png"] forState:normal];
    [three setImage:[UIImage imageNamed:@"estrella1.png"] forState:normal];
    [four setImage:[UIImage imageNamed:@"estrella1.png"] forState:normal];
    [five setImage:[UIImage imageNamed:@"estrella2.png"] forState:normal];
}

-(IBAction)cinco:(id)sender{
    [one setImage:[UIImage imageNamed:@"estrella1.png"] forState:normal];
    [two setImage:[UIImage imageNamed:@"estrella1.png"] forState:normal];
    [three setImage:[UIImage imageNamed:@"estrella1.png"] forState:normal];
    [four setImage:[UIImage imageNamed:@"estrella1.png"] forState:normal];
    [five setImage:[UIImage imageNamed:@"estrella1.png"] forState:normal];
}




-(IBAction)add_favoritas:(id)sender{
    
}


-(IBAction)add_lista_super
{
//    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
//    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"listaArticulos"];
//    [self presentViewController:cambiarViewController animated:YES completion:nil];
    
    self.tabBarController.selectedViewController
    = [self.tabBarController.viewControllers objectAtIndex:2];
    
//    UINavigationController * navigationController = [tab.viewControllers objectAtIndex:2];
//    [navigationController pushViewController:detailViewController animated:NO];
}




-(void)fiaReceta:(Receta *)r nombreCategoria:(NSString *)nombre {
    receta = r;
    nombreCategoria = nombre;
}

-(IBAction)clickVota:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults synchronize];
    
    //    LOGIN CORRECTO
    if (([defaults stringForKey:@"log_ref"])==nil) {
        
        //    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
        //    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"Reg_user"];
        //    [self presentViewController:cambiarViewController animated:YES completion:nil];
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UserLogin *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"Reg_user"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else{
        
    }
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==tabla_ingredientes) {
        return 1;
    }
    else
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==tabla_ingredientes) {
        return [ingredienteList count];
    }
    else
    return [comentarioList count];
}


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return comentarioList;
//}



-(IBAction)clickComparte:(id)sender {
    NSString *name;
    NSString *time;
    NSString *people;
    
    name=[receta dameNombreReceta];
    time=[receta dameMinutosReceta];
    people =[receta damePorcionReceta];
    
    NSString *textToShare = [NSString stringWithFormat:@"%@ en: %@ para: %@", name, time, people];
    NSString *when =[receta dameUrlImagen];
//    NSString *ServerAddStatic =@"http://zavordigital.com/la_huerta/statics/imagenes_recetas/";
    NSString* eventFoto = [NSString stringWithFormat:@"%@", when ];
    UIImage *imageToShare = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:eventFoto]]];
    NSURL *urlToShare = [NSURL URLWithString:@"https://www.facebook.com/zamiel.melee"];

    
    NSArray *activityItems = [NSArray arrayWithObjects:textToShare, imageToShare, urlToShare, nil];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityVC animated:TRUE completion:nil];
    
}

-(IBAction)uploadComent{
    if ([addComent.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Debes ingresar un comentario en la receta" delegate:self cancelButtonTitle:@"Cerrar" otherButtonTitles:nil];
        [alert show];
    }
    else{
       NSString *idreceta = [receta dameIdReceta];
       NSString *sUrl = [NSString stringWithFormat:@"%@%@/%@", SERVIDOR, SAVE_COMENTARIO, idreceta];
    
        NSURL *url = [NSURL URLWithString:sUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
    
    
        NSString * p = [NSString stringWithFormat:@"comentario=%@",addComent.text];
    
        NSLog(@"Cadena Reg:%@", p);
    
        NSString *postLength = [NSString stringWithFormat:@"%d", [p length]];
    
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
        NSData *postBody = [p dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        [request setHTTPBody:postBody];
        //
        NSURLResponse *response = NULL;
    
        NSError *requestError = NULL;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    // begin**
    //    end
    
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
        if([responseString isEqualToString:@"-1"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Hay conexion a Internet o no es posible añadir el comentario." message:@"Revise su conexión a internet." delegate:nil cancelButtonTitle:@"Cerrar" otherButtonTitles: nil];
            [alert show];
        }
    
    addComent.text =@"";
    self.comentarioList = [[NSMutableArray alloc] initWithCapacity:0];
    ConexionComentarios *conexion = [[ConexionComentarios alloc] init];
    self.comentarioList = [conexion GetComent:idreceta];
    [self performSelectorOnMainThread:@selector(terminaDescargaTemasTips) withObject:nil waitUntilDone:NO];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [addComent resignFirstResponder];
    [UIView beginAnimations:@"BajandoFondo" context:nil];
    [UIView setAnimationDuration:0.3];
    [fondo_comentarios setFrame:(CGRect){0, 0, fondo_comentarios.frame.size.width, fondo_comentarios.frame.size.height}];
    [UIView commitAnimations];
    
    if (textField==addComent) {
        [self uploadComent];
    }
    return YES;
    
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [addComent resignFirstResponder];
    
    
    [UIView beginAnimations:@"BajandoFondo" context:nil];
    [UIView setAnimationDuration:0.3];
    [fondo_comentarios setFrame:(CGRect){0, 0, fondo_comentarios.frame.size.width, fondo_comentarios.frame.size.height}];
    [UIView commitAnimations];
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == addComent) {
        [UIView beginAnimations:@"SubiendoFondo" context:nil];
        [UIView setAnimationDuration:0.3];
        [fondo_comentarios setFrame:(CGRect){0,-140,  fondo_comentarios.frame.size.width, fondo_comentarios.frame.size.height}];
        [UIView commitAnimations];
    }
    
}




-(IBAction)pasoPaso:(id)sender {
    labelPasoPaso.textColor = [UIColor colorWithRed:140.0/255.0 green:202.0/255.0 blue:65.0/255.0 alpha:1];
    labelComentarios.textColor = [UIColor colorWithRed:189.0/255.0 green:195.0/255.0 blue:199.0/255.0 alpha:1];
    labelIngredientes.textColor = [UIColor colorWithRed:189.0/255.0 green:195.0/255.0 blue:199.0/255.0 alpha:1];
    [btnPasoPaso setImage:[UIImage imageNamed:@"btn_presionado.png"] forState:UIControlStateNormal];
    [btnComentarios setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btnIngredientes setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    
    viewPasoPaso.hidden = NO;
    viewComentarios.hidden =NO;
    viewIngredientes.hidden =NO;

//    here

    Pasos_add.text=[receta damePasos];
    
}

-(IBAction)ingredientes:(id)sender {
    labelPasoPaso.textColor = [UIColor colorWithRed:189.0/255.0 green:195.0/255.0 blue:199.0/255.0 alpha:1];
    labelComentarios.textColor = [UIColor colorWithRed:189.0/255.0 green:195.0/255.0 blue:199.0/255.0 alpha:1];
    labelIngredientes.textColor = [UIColor colorWithRed:140.0/255.0 green:202.0/255.0 blue:65.0/255.0 alpha:1];
    [btnPasoPaso setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btnComentarios setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btnIngredientes setImage:[UIImage imageNamed:@"btn_presionado.png"] forState:UIControlStateNormal];

    viewIngredientes.hidden = NO;
    viewComentarios.hidden = NO;
    viewPasoPaso.hidden = YES;
    
    
    Util *u = [[Util alloc] init];
    viewEspera = [u creaViewEspera];
    viewEspera.center = self.view.center;
    [self.view addSubview:viewEspera];
    
    
    NSString *idreceta =  [receta dameIdReceta];
    self.comentarioList = [[NSMutableArray alloc] initWithCapacity:0];
    ConexionComentarios *conexion = [[ConexionComentarios alloc] init];
    self.ingredienteList = [conexion getIngredientes:idreceta];
    
    
    
    [self performSelectorOnMainThread:@selector(terminaDescargaIngredientes) withObject:nil waitUntilDone:NO];
    
}

-(IBAction)comentarios:(id)sender {
    labelPasoPaso.textColor = [UIColor colorWithRed:189.0/255.0 green:195.0/255.0 blue:199.0/255.0 alpha:1];
    labelComentarios.textColor = [UIColor colorWithRed:140.0/255.0 green:202.0/255.0 blue:65.0/255.0 alpha:1];
    labelIngredientes.textColor = [UIColor colorWithRed:189.0/255.0 green:195.0/255.0 blue:199.0/255.0 alpha:1];
    [btnPasoPaso setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btnComentarios setImage:[UIImage imageNamed:@"btn_presionado.png"] forState:UIControlStateNormal];
    [btnIngredientes setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    viewComentarios.hidden = NO;
    viewIngredientes.hidden = YES;
    viewPasoPaso.hidden = YES;
    
    Util *u = [[Util alloc] init];
    viewEspera = [u creaViewEspera];
    viewEspera.center = self.view.center;
    [self.view addSubview:viewEspera];
    
    //here
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults synchronize];
    //    LOGIN CORRECTO
//    if (([defaults stringForKey:@"log_ref"])==nil) {
//    
//        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UserLogin *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"Reg_user"];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else
//    {
        NSString *idreceta =  [receta dameIdReceta];
        self.comentarioList = [[NSMutableArray alloc] initWithCapacity:0];
        ConexionComentarios *conexion = [[ConexionComentarios alloc] init];
//        [receta dameIdReceta]
        self.comentarioList = [conexion GetComent:idreceta];
        [self performSelectorOnMainThread:@selector(terminaDescargaTemasTips) withObject:nil waitUntilDone:NO];
//    }
    
}


-(void)terminaDescargaTemasTips {
    viewEspera.hidden = YES;
    if (comentarioList == NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Hay conexion a Internet o no hay comentarios." message:@"Revise su conexión a internet." delegate:nil cancelButtonTitle:@"Cerrar" otherButtonTitles: nil];
        [alert show];
    } else {
        
        [tabla_comentarios reloadData];
        
    }
}


-(void)terminaDescargaIngredientes {
    viewEspera.hidden = YES;
    if (ingredienteList == NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Hay conexion a Internet o no hay ingredientes." message:@"Revise su conexión a internet." delegate:nil cancelButtonTitle:@"Cerrar" otherButtonTitles: nil];
        [alert show];
    } else {
        int n;
        int j = (int)ingredienteList.count;
        for (n=1; n<=j; n++) {
            [temp_array addObject:[NSNumber numberWithBool:NO]];
        }
        [tabla_ingredientes reloadData];
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (tableView==tabla_ingredientes) {
        if (tabla_ingredientes == nil) {
            CellIdentifier = @"ingrediente_show";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            return cell;
        }
        else {
            CellIdentifier=@"ingrediente_show";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            UILabel *nombre_l = (UILabel *)[cell viewWithTag:13];
            UIButton *ingredient_l=(UIButton *)[cell viewWithTag:12];
            
            NSDictionary* evento  = [self.ingredienteList objectAtIndex:indexPath.row];

            
            nombre_l.text = [NSString stringWithFormat: @"%@", [evento objectForKey:@"ingrediente_nombre"]];
//            llamada
            
            [ingredient_l addTarget:self action:@selector(ingredient_select:)
                   forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
    }
    
    if (tableView==tabla_comentarios) {
        
        if (tabla_comentarios == nil) {
            CellIdentifier = @"data_coment";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            
            return cell;
        } else {
            CellIdentifier = @"data_coment";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            UILabel *nombre_l = (UILabel *)[cell viewWithTag:14];
            
            NSDictionary* evento  = [self.comentarioList objectAtIndex:indexPath.row];
            
            sleep(1);
            
            nombre_l.text = [NSString stringWithFormat: @"%@", [evento objectForKey:@"comentario_tx"]];
            
            
            return cell;
        }
        
    }
//    ending
            return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (tableView==tabla_ingredientes) {
//        [circulo setImage:[UIImage imageNamed:@"circulo2.png"] forState:normal];
//    }
//}


//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        if (tableView==tabla_ingredientes) {
////            [[AppDelegate sharedAppDelegate].compartido addObject:[self.ingredienteList objectAtIndex:i.row]];
//            [AppDelegate sharedAppDelegate].compartido = [self.ingredienteList objectAtIndex:indexPath.row];
//
//
//        }
//}




-(IBAction)regresar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)creaViewPasos {
//    scrollPasos = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 10, 280, viewPasoPaso.frame.size.height - 90)];
//    scrollPasos.backgroundColor = [UIColor redColor];
//    [viewPasoPaso addSubview:scrollPasos];
//    UIButton *btnAgregarAFavoritos = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnAgregarAFavoritos setImage:[UIImage imageNamed:@"btn_favoritas"] forState:UIControlStateNormal];
//    btnAgregarAFavoritos.frame = CGRectMake(80, viewPasoPaso.frame.size.height - 70, 160, 50);
//    [viewPasoPaso addSubview:btnAgregarAFavoritos];
}

-(void)creaViewIngredientes {
    scrollIngredientes = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 10, 315, viewIngredientes.frame.size.height - 100)];
    
//    here
    
}

-(void)creaViewComentarios {
    
}

@end
