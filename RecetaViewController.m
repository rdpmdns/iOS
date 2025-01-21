//
//  RecetaViewController.m
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 23/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "RecetaViewController.h"
#import "Receta.h"
#import "ConexionServidor.h"
#import "Util.h"
#import "VisorRecetaViewController.h"

@interface RecetaViewController () {
    NSMutableArray *recetas;
    NSMutableArray *listaBusqueda;
    UIView *viewEspera;
    NSString *nombreCategoria;
    NSString *idCategoria;
    BOOL buscar;
}

@end

@implementation RecetaViewController

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
    busqueda.delegate = self;
    Util *u = [[Util alloc] init];
    viewEspera = [u creaViewEspera];
    viewEspera.center = self.view.center;
    [self.view addSubview:viewEspera];
    labelTitulo.text = nombreCategoria;
    listaBusqueda = [[NSMutableArray alloc] init];
    [NSThread detachNewThreadSelector:@selector(descargarRecetas) toTarget:self withObject:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)regresar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)fijaTituloCategoria:(NSString *)c idReceta:(NSString *)i {
    nombreCategoria = c;
    idCategoria = i;
}

-(void)descargarRecetas {
    [recetas removeAllObjects];
    ConexionServidor *conexion = [[ConexionServidor alloc] init];
    recetas = [conexion dameRecetas:idCategoria];
    [self performSelectorOnMainThread:@selector(terminaDescargaRecetas) withObject:nil waitUntilDone:NO];
}

-(void)buscaRecetas {
    NSString *tx=busqueda.text;
    [recetas removeAllObjects];
    ConexionServidor *conexion = [[ConexionServidor alloc] init];
    recetas = [conexion dameRecetas:tx];
    [self performSelectorOnMainThread:@selector(terminaDescargaRecetas) withObject:nil waitUntilDone:NO];
}


-(void)terminaDescargaRecetas {
    viewEspera.hidden = YES;
    if (recetas == NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No se pudieron descargar las recetas." message:@"Revise su conexión a internet e intente nuevamente." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else {
        [tabla reloadData];
        [NSThread detachNewThreadSelector:@selector(descargaImagenes) toTarget:self withObject:nil];
    }
}

-(void)descargaImagenes {
    sleep(1);
    for (Receta *r in recetas)  {
        UIImage *imagenDescargada = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[r dameUrlImagen]]]];
        [r fijaImagen:imagenDescargada];
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
    if (buscar) {
        return [listaBusqueda count];
    }
    return [recetas count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Receta *r;
    if (buscar) {
        r = [listaBusqueda objectAtIndex:indexPath.row];
    } else {
        r = [recetas objectAtIndex:indexPath.row];
    }
     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     VisorRecetaViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"visorReceta"];
    [vc fiaReceta:r nombreCategoria:nombreCategoria];
     [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    UIImageView *flecha = nil;
    UIImageView *imagen = nil;
    UIImageView *estrellas = nil;
    UIImageView *reloj = nil;
    UIImageView *personas = nil;
    UILabel *labelEstrellas = nil;
    UILabel *labelReloj = nil;
    UILabel *labelPersonas = nil;
    UILabel *label = nil;
    UIImageView *linea = nil;
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainCell"];
        label = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 220, 35)];
        label.numberOfLines = 2;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:230.0/255.0 green:126.0/255.0 blue:34.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:14];
        label.tag = 101;
        flecha = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next.png"]];
        flecha.frame = CGRectMake(285, 30, 15, 25);
        flecha.tag = 100;
        imagen = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 70)];
        imagen.tag = 102;
        
//        here start in show
        estrellas = [[UIImageView alloc] initWithFrame:CGRectMake(100, 30, 100, 25)];
        estrellas.image = [UIImage imageNamed:@"estrellas2.png"];
        estrellas.tag = 103;
        
        
        reloj = [[UIImageView alloc] initWithFrame:CGRectMake(100, 60, 15, 15)];
        reloj.image = [UIImage imageNamed:@"reloj.png"];
        reloj.tag = 104;
        personas = [[UIImageView alloc] initWithFrame:CGRectMake(175, 60, 15, 15)];
        personas.image = [UIImage imageNamed:@"personas.png"];
        personas.tag = 105;
        labelEstrellas = [[UILabel alloc] initWithFrame:CGRectMake(220, 35, 100, 15)];
        labelEstrellas.backgroundColor = [UIColor clearColor];
        labelEstrellas.font = [UIFont systemFontOfSize:10];
        labelEstrellas.textColor = [UIColor colorWithRed:127.0/255.0 green:140.0/255.0 blue:141.0/255.0 alpha:1];
        labelEstrellas.tag = 106;
        labelReloj = [[UILabel alloc] initWithFrame:CGRectMake(115, 63, 40, 10)];
        labelReloj.backgroundColor = [UIColor clearColor];
        labelReloj.font = [UIFont systemFontOfSize:10];
        labelReloj.textColor = [UIColor colorWithRed:127.0/255.0 green:140.0/255.0 blue:141.0/255.0 alpha:1];
        labelReloj.tag = 107;
        labelPersonas = [[UILabel alloc] initWithFrame:CGRectMake(195, 63, 70, 10)];
        labelPersonas.backgroundColor = [UIColor clearColor];
        labelPersonas.font = [UIFont systemFontOfSize:10];
        labelPersonas.textColor = [UIColor colorWithRed:127.0/255.0 green:140.0/255.0 blue:141.0/255.0 alpha:1];
        labelPersonas.tag = 108;
        linea = [[UIImageView alloc] initWithFrame:CGRectMake(165, 58, 3, 16)];
        linea.image = [UIImage imageNamed:@"linea_vertical.png"];
        linea.tag = 109;
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:flecha];
        [cell.contentView addSubview:imagen];
        [cell.contentView addSubview:estrellas];
        [cell.contentView addSubview:reloj];
        [cell.contentView addSubview:personas];
        [cell.contentView addSubview:labelEstrellas];
        [cell.contentView addSubview:labelReloj];
        [cell.contentView addSubview:labelPersonas];
        [cell.contentView addSubview:linea];
    } else {
        flecha = ((UIImageView *) [cell.contentView viewWithTag:100]);
        label = ((UILabel *) [cell.contentView viewWithTag:101]);
        imagen = ((UIImageView *) [cell.contentView viewWithTag:102]);
        estrellas = ((UIImageView *) [cell.contentView viewWithTag:103]);
        reloj = ((UIImageView *) [cell.contentView viewWithTag:104]);
        personas = ((UIImageView *) [cell.contentView viewWithTag:105]);
        labelEstrellas = ((UILabel *) [cell.contentView viewWithTag:106]);
        labelReloj = ((UILabel *) [cell.contentView viewWithTag:107]);
        labelPersonas = ((UILabel *) [cell.contentView viewWithTag:108]);
        linea = ((UIImageView *) [cell.contentView viewWithTag:109]);
    }
    cell.backgroundColor = [UIColor clearColor];
    Receta *r;
    if (buscar) {
        r = [listaBusqueda objectAtIndex:indexPath.row];
    } else {
        r = [recetas objectAtIndex:indexPath.row];
    }
    label.text = [r dameNombreReceta];
    if ([r dameImagen] == NULL) {
        imagen.image = [UIImage imageNamed:@""];
    } else {
        imagen.image = [r dameImagen];
    }
    labelEstrellas.text = [NSString stringWithFormat:@"%@ votos.",[r dameVotos]];
    labelPersonas.text = [r damePorcionReceta];
    labelReloj.text = [r dameMinutosReceta];
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
            [NSThread detachNewThreadSelector:@selector(buscaRecetas) toTarget:self withObject:nil];
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"ENTRO %@", textField.text);
    if (textField.text.length <= 1) {
        buscar = NO;
    } else {
        viewEspera.hidden = NO;
        [listaBusqueda removeAllObjects];
        for(Receta *r in recetas) {
            NSRange range = [[r dameNombreReceta] rangeOfString:textField.text options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [listaBusqueda addObject:r];
                // [self insertaFila];
            }
        }
        buscar = YES;
    }
    [tabla reloadData];
    viewEspera.hidden = YES;
    return YES;
}


@end
