//
//  AgregaArticulosViewController.m
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 21/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "AgregaArticulosViewController.h"
#import "Productos.h"
#import "DataBase.h"
#import "Util.h"

@interface AgregaArticulosViewController () {
    DataBase *db;
    NSMutableArray *productos;
    UIView *viewAgregaProducto;
    UITextField *nombre;
    NSMutableArray *seleccionados;
    float version;
    UIView *viewEspera;
    NSString *idLista;
}

@end

@implementation AgregaArticulosViewController

@synthesize delegate;

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
    tabla.backgroundColor = [UIColor clearColor];
    tabla.separatorColor = [UIColor clearColor];
    
    db = [[DataBase alloc] init];
    [db iniciar];
    
    productos = [[NSMutableArray alloc] init];
    
    [self creaViewAgregaProducto];
    seleccionados = [[NSMutableArray alloc] init];
    NSString *ver = [[UIDevice currentDevice] systemVersion];
    version = [ver floatValue];
    Util *u = [[Util alloc] init];
    viewEspera = [u creaViewEspera];
    viewEspera.center = self.view.center;
    [self.view addSubview:viewEspera];
    
}

-(void)viewDidAppear:(BOOL)animated {
    viewEspera.hidden = NO;
    [productos removeAllObjects];
    productos = [db dameProductos];
    [tabla reloadData];
    viewEspera.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [productos count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    UIButton *btnAgregar = nil;
    UIImageView *linea = nil;
    UILabel *label = nil;
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainCell"];
        label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 275, 50)];
        label.numberOfLines = 5;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:127.0/255.0 green:140.0/255.0 blue:141.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:14];
        label.tag = 101;
        btnAgregar = [UIButton buttonWithType:UIButtonTypeCustom];
        btnAgregar.frame = CGRectMake(265, 10, 25, 25);
        [btnAgregar setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        [btnAgregar addTarget:self action:@selector(agregaSeleccionado:) forControlEvents:UIControlEventTouchUpInside];
        btnAgregar.tag = 100;
        linea = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, 280, 3)];
        linea.image = [UIImage imageNamed:@"linea.png"];
        linea.tag = 102;
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:btnAgregar];
        [cell.contentView addSubview:linea];
    } else {
        btnAgregar = ((UIButton *) [cell.contentView viewWithTag:100]);
        label = ((UILabel *) [cell.contentView viewWithTag:101]);
        linea = ((UIImageView *) [cell.contentView viewWithTag:102]);
    }
    cell.backgroundColor = [UIColor clearColor];
    Productos *p = [productos objectAtIndex:indexPath.row];
    label.text = [p dameNombre];
    if ([p estaEnLista]) {
        [btnAgregar setImage:[UIImage imageNamed:@"check_2"] forState:UIControlStateNormal];
    } else {
        [btnAgregar setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    }
    return cell;
}

-(void)agregaSeleccionado:(UIButton *)sender {
    UITableViewCell *c;
    if (version < 7.0) {
        c = ((UITableViewCell *)[[sender superview] superview]);
    } else {
        c = ((UITableViewCell *)[[[sender superview] superview] superview]);
    }
    NSIndexPath *i = ((NSIndexPath *) [tabla indexPathForCell:c]);
    Productos *p = [productos objectAtIndex:i.row];
    if ([p estaEnLista]) {
        [p fijaEstaEnLista:NO];
        [seleccionados removeObject:p];
    } else {
        [p fijaEstaEnLista:YES];
        [seleccionados addObject:p];
    }
    [tabla reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger row = [indexPath row];
        NSLog(@"row: %d",row);
        [self borraLista:row];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Eliminar";
}


-(IBAction)nuevoProducto:(id)sender {
    if (viewAgregaProducto.isHidden) {
        viewAgregaProducto.hidden = NO;
    } else {
        viewAgregaProducto.hidden = YES;
    }
}

-(void)borraLista: (int)f {
    Productos *p = [productos objectAtIndex:f];
    [productos removeObjectAtIndex:f];
    [tabla reloadData];
    [db borraProducto:[p dameIdProducto]];
}

-(IBAction)regresar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)creaViewAgregaProducto {
    viewAgregaProducto = [[UIView alloc] initWithFrame:CGRectMake(40, 100, 240, 120)];
    viewAgregaProducto.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:240.0/255.0 blue:241.0/255.0 alpha:1];
    viewAgregaProducto.layer.cornerRadius = 10; // this value vary as per your desire
    viewAgregaProducto.clipsToBounds = YES;
    [self.view addSubview:viewAgregaProducto];
    UIButton *btnCerrar = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCerrar setImage:[UIImage imageNamed:@"btn_cerrar.png"] forState:UIControlStateNormal];
    btnCerrar.frame = CGRectMake(210, 5, 20, 20);
    [btnCerrar addTarget:self action:@selector(cierraAgregaArticulo:) forControlEvents:UIControlEventTouchUpInside];
    nombre = [[UITextField alloc] initWithFrame:CGRectMake(10, 40, 220, 30)];
    nombre.placeholder = @"Nombre del producto.";
    nombre.delegate = self;
    nombre.borderStyle = UITextBorderStyleRoundedRect;
    nombre.font = [UIFont systemFontOfSize:15];
    nombre.autocorrectionType = UITextAutocorrectionTypeNo;
    nombre.keyboardType = UIKeyboardTypeDefault;
    nombre.returnKeyType = UIReturnKeyDone;
    nombre.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIButton *btnAgregar = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAgregar setImage:[UIImage imageNamed:@"btn_ok.png"] forState:UIControlStateNormal];
    [btnAgregar addTarget:self action:@selector(agregaArticulo:) forControlEvents:UIControlEventTouchUpInside];
    btnAgregar.frame = CGRectMake(105, 85, 30, 25);
    [viewAgregaProducto addSubview:btnCerrar];
    [viewAgregaProducto addSubview:nombre];
    [viewAgregaProducto addSubview:btnAgregar];
    viewAgregaProducto.hidden = YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [nombre resignFirstResponder];
    return YES;
}

-(void)cierraAgregaArticulo:(UIButton *)sender {
    viewAgregaProducto.hidden = YES;
}

-(void)agregaArticulo:(UIButton *)sender {
    if (nombre.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ingrese el nombre del producto." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else {
        Productos *p = [[Productos alloc] init];
        NSString *idProducto = [db agregaProducto:nombre.text];
        [p fijaIdProducto:idProducto nombre:nombre.text descripcion:@"" comprado:NO];
        [productos addObject:p];
        [tabla reloadData];
        viewAgregaProducto.hidden = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Producto agregado con éxito." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

-(IBAction)terminaSeleccion:(id)sender {
    if (seleccionados.count > 0) {
        viewEspera.hidden = NO;
//        begin
        NSMutableArray *seleccionFix = [[NSMutableArray alloc] init];
        for (Productos *p in seleccionados) {
            
            NSLog(@"Lista fijada %@", idLista);
            NSString *idProducto = [db agregaProductosLista:[p dameIdProducto] idLista:idLista comprado:@"0"];
            Productos *pAux = [[Productos alloc] init];
            [pAux fijaIdProducto:idProducto nombre:[p dameNombre] descripcion:[p dameDescripcion] comprado:NO];
            [seleccionFix addObject:pAux];
        }
//        add listaArticulos
        [delegate regresaArticulos:seleccionFix parent:self];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ingrese al menos un producto." message:Nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

-(void)fijaIdLista:(NSString *)i {
    idLista = i;
}

@end
