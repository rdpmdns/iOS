//
//  FavoritasViewController.m
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 20/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "FavoritasViewController.h"
#import "ConexionUsuarios.h"
#import "AppDelegate.h"
#import "Util.h"


@interface FavoritasViewController () {
    
    UIView *viewEspera;
    NSString *IdAgente;
    NSString *id_user;
    NSString *FolioCliente;
    NSString *NombreCliente;
    NSString *DireccionCliente;
    
}

//@property (strong, nonatomic) FavoritasViewController *tabla_instruccion;

@end

@implementation FavoritasViewController
@synthesize FavoritasList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    tabla_favoritas.dataSource = self;
    tabla_favoritas.delegate = self;
    tabla_favoritas.backgroundColor = [UIColor clearColor];
    Util *u = [[Util alloc] init];
    viewEspera = [u creaViewEspera];
    viewEspera.center = self.view.center;
    [self.view addSubview:viewEspera];
    [NSThread detachNewThreadSelector:@selector(descargarTemasTips) toTarget:self withObject:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)regresar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)fijaCliente:(NSString *)c idCliente:(NSString *)i {
    NombreCliente= c;
    IdAgente = i;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [Clientes count];
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return FavoritasList.count;
}



-(void)descargarTemasTips {
    
    //    [Clientes removeAllObjects];
    self.FavoritasList = [[NSMutableArray alloc] initWithCapacity:0];
    ConexionUsuarios *conexion = [[ConexionUsuarios alloc] init];
    self.FavoritasList = [conexion Get_favorita:id_user];
    [self performSelectorOnMainThread:@selector(terminaDescargaTemasTips) withObject:nil waitUntilDone:NO];
}



-(void)terminaDescargaTemasTips {
    viewEspera.hidden = YES;
    if (FavoritasList == NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Hay conexion a Internet o no hay Recetas favoritas" message:@"Revise su conexión a internet." delegate:nil cancelButtonTitle:@"Cerrar" otherButtonTitles: nil];
        [alert show];
    } else {
        
        [tabla_favoritas reloadData];
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tabla_favoritas == nil) {
        static NSString *CellIdentifier = @"label_favorita";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"label_favorita";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        UILabel *nombre_l = (UILabel *)[cell viewWithTag:123];
        
        NSDictionary* evento  = [self.FavoritasList objectAtIndex:indexPath.row];
        
        sleep(1);
        
        nombre_l.text = [NSString stringWithFormat: @"%@", [evento objectForKey:@"instruccion_nombre"]];
        
        
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [AppDelegate sharedAppDelegate].compartido = Nil;
    [AppDelegate sharedAppDelegate].compartido = [self.FavoritasList objectAtIndex:indexPath.row];
}


//-(BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [busqueda resignFirstResponder];
//    return YES;
//}
//
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [busqueda resignFirstResponder];
//}



@end
