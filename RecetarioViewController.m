//
//  RecetarioViewController.m
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 22/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "RecetarioViewController.h"
#import "ConexionServidor.h"
#import "Categorias.h"
#import "Util.h"
#import "RecetaViewController.h"

@interface RecetarioViewController () {
    NSMutableArray *categorias;
    UIView *viewEspera;
    BOOL salio;
}

@end

@implementation RecetarioViewController

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
    tabla.dataSource = self;
    tabla.delegate = self;
    Util *u = [[Util alloc] init];
    viewEspera = [u creaViewEspera];
    viewEspera.center = self.view.center;
    [self.view addSubview:viewEspera];
    busqueda.delegate = self;
    salio = NO;
}

-(void)viewDidAppear:(BOOL)animated {
    if (!salio) {
        [NSThread detachNewThreadSelector:@selector(descargarCategorias) toTarget:self withObject:nil];
    }
    salio = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)regresar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)descargarCategorias {
    @synchronized(self) {
        [categorias removeAllObjects];
        ConexionServidor *conexion = [[ConexionServidor alloc] init];
        categorias = [conexion dameCategorias];
        [self performSelectorOnMainThread:@selector(terminaDescargaCategorias) withObject:nil waitUntilDone:NO];
    }
}


-(void)buscaCategorias {
    @synchronized(self) {
        [categorias removeAllObjects];
        NSString *tx= busqueda.text;
        ConexionServidor *conexion = [[ConexionServidor alloc] init];
        categorias = [conexion buscaCategorias:tx];
        [self performSelectorOnMainThread:@selector(terminaDescargaCategorias) withObject:nil waitUntilDone:NO];
    }
}

-(void)terminaDescargaCategorias {
    viewEspera.hidden = YES;
    if (categorias == NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No se pudieron descargar las recetas." message:@"Revise su conexión a internet e intente nuevamente." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else {
        NSLog(@"TAMANO %d", categorias.count);
        [tabla reloadData];
        [NSThread detachNewThreadSelector:@selector(descargaImagenes) toTarget:self withObject:nil];
    }
}

-(void)descargaImagenes {
    sleep(1);
    for (Categorias *c in categorias)  {
        UIImage *imagenDescargada = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[c dameUrlCategoria]]]];
        [c fijaImagen:imagenDescargada];
        [self performSelectorOnMainThread:@selector(terminaDescargarImagen)
                               withObject:nil waitUntilDone:YES];
    }
}

-(void)terminaDescargarImagen {
    [tabla reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categorias count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    salio = YES;
    Categorias *c = [categorias objectAtIndex:indexPath.row];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RecetaViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"recetas"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [vc fijaTituloCategoria:[c dameNombreCategoria] idReceta:[c dameIdCategoria]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    UIImageView *flecha = nil;
    UIImageView *imagen = nil;
    UIImageView *codigo = nil;
    UILabel *label = nil;
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainCell"];
        label = [[UILabel alloc] initWithFrame:CGRectMake(115, 0, 150, 50)];
        label.numberOfLines = 5;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:127.0/255.0 green:140.0/255.0 blue:141.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:14];
        label.tag = 101;
        flecha = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next.png"]];
        flecha.frame = CGRectMake(285, 30, 15, 25);
        flecha.tag = 100;
        imagen = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 70)];
        imagen.tag = 102;
        codigo = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        codigo.image = [UIImage imageNamed:@"codigo.png"];
        codigo.tag = 103;
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:flecha];
        [cell.contentView addSubview:imagen];
        [cell.contentView addSubview:codigo];
    } else {
        flecha = ((UIImageView *) [cell.contentView viewWithTag:100]);
        label = ((UILabel *) [cell.contentView viewWithTag:101]);
        imagen = ((UIImageView *) [cell.contentView viewWithTag:102]);
        codigo = ((UIImageView *) [cell.contentView viewWithTag:103]);
    }
    cell.backgroundColor = [UIColor clearColor];
    Categorias *c = [categorias objectAtIndex:indexPath.row];
    label.text = [c dameNombreCategoria];
    if ([c dameImagen] == NULL) {
        imagen.image = [UIImage imageNamed:@""];
    } else {
        imagen.image = [c dameImagen];
    }
    if ([c esPrivada]) {
        codigo.hidden = NO;
    } else {
        codigo.hidden = YES;
    }
    return cell;
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
