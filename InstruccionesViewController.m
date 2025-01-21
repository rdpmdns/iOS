//
//  InstruccionesViewController.m
//  La Huerta
//
//  Created by Daniel on 12/03/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "InstruccionesViewController.h"
#import "ConexionInstrucciones.h"
#import "AppDelegate.h"
#import "Util.h"

@interface InstruccionesViewController () {
    
    UIView *viewEspera;
    NSString *IdAgente;
    NSString *FolioCliente;
    NSString *NombreCliente;
    NSString *DireccionCliente;
    
}

@property (strong, nonatomic) InstruccionesViewController *tabla_instruccion;

@end


@implementation InstruccionesViewController
@synthesize InstruccionesList;

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
    
    tabla_instrucciones.dataSource = self;
    tabla_instrucciones.delegate = self;
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
    return InstruccionesList.count;
}



-(void)descargarTemasTips {
    
    //    [Clientes removeAllObjects];
    self.InstruccionesList = [[NSMutableArray alloc] initWithCapacity:0];
    ConexionInstrucciones *conexion = [[ConexionInstrucciones alloc] init];
    self.InstruccionesList = [conexion GetInstrucciones];
    [self performSelectorOnMainThread:@selector(terminaDescargaTemasTips) withObject:nil waitUntilDone:NO];
}


-(void)buscaCategorias {
    @synchronized(self) {
        [InstruccionesList removeAllObjects];
        NSString *tx= busqueda.text;
        ConexionInstrucciones *conexion = [[ConexionInstrucciones alloc] init];
        self.InstruccionesList = [conexion  SearchInstruc:tx];
        [self performSelectorOnMainThread:@selector(terminaDescargaTemasTips) withObject:nil waitUntilDone:NO];
    }
}

-(void)terminaDescargaTemasTips {
    viewEspera.hidden = YES;
    if (InstruccionesList == NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Hay conexion a Internet o no hay Instrucciones." message:@"Revise su conexión a internet." delegate:nil cancelButtonTitle:@"Cerrar" otherButtonTitles: nil];
        [alert show];
    } else {
        
        [tabla_instrucciones reloadData];
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tabla_instrucciones == nil) {
        static NSString *CellIdentifier = @"label_ins";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"label_ins";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        UILabel *nombre_l = (UILabel *)[cell viewWithTag:123];
        
        NSDictionary* evento  = [self.InstruccionesList objectAtIndex:indexPath.row];
        
        sleep(1);
        
        nombre_l.text = [NSString stringWithFormat: @"%@", [evento objectForKey:@"instruccion_nombre"]];
        
        
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [AppDelegate sharedAppDelegate].compartido = Nil;
    [AppDelegate sharedAppDelegate].compartido = [self.InstruccionesList objectAtIndex:indexPath.row];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [busqueda resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [busqueda resignFirstResponder];
}


-(IBAction)buscar:(id)sender {
    [busqueda resignFirstResponder];
    if (busqueda.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ingrese una palabra a buscar." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else {
        if (!viewEspera.isHidden) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ya se encuentra una busqueda en curso." message:@"Espere a que termine para iniciar una nueva busqueda." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        } else {
            viewEspera.hidden = NO;
            [NSThread detachNewThreadSelector:@selector(buscaCategorias) toTarget:self withObject:nil];
        }
    }
}


@end
