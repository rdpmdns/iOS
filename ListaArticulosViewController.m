//
//  ListaArticulosViewController.m
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 21/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "ListaArticulosViewController.h"
#import "DataBase.h"
#import "Productos.h"

@interface ListaArticulosViewController () {
    NSString *idLista;
    DataBase *db;
    NSMutableArray *productos;
    UITextField *nombre;
    float version;
    AgregaArticulosViewController *vc;
}

@end

@implementation ListaArticulosViewController

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
    productos = [db dameProductosListasSuper:idLista];
    NSString *ver = [[UIDevice currentDevice] systemVersion];
    version = [ver floatValue];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"agregaArticulo"];
    [vc fijaIdLista:idLista];
    vc.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fijaIdLista:(NSString *)i {
    idLista = i;
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
    /*Encuestas *e = [encuestas objectAtIndex:indexPath.row];
     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     PreguntasViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"preguntas"];;
     vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
     [vc fijaIdEncuesta:[e dameIdEncuesta] titulo:[e dameNombreEncuesta]];
     [self.navigationController pushViewController:vc animated:YES];*/
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
        [db cambiaEstatusProductoLista:[p dameIdProducto] comprado:@"0"];
    } else {
        [p fijaEstaEnLista:YES];
        [db cambiaEstatusProductoLista:[p dameIdProducto] comprado:@"1"];
    }
    [tabla reloadData];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [nombre resignFirstResponder];
    return YES;
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

-(void)borraLista: (int)f {
    Productos *p = [productos objectAtIndex:f];
    [productos removeObjectAtIndex:f];
    [tabla reloadData];
    [db borraProductoLista:[p dameIdProducto]];
}

-(IBAction)regresar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)agregarArticulos:(id)sender {
    [self.navigationController pushViewController:vc animated:YES];
}



-(IBAction)Limpiar:(id)sender{
//    [self borraLista:1];
}



-(void)regresaArticulos:(NSMutableArray *)articulos parent:(AgregaArticulosViewController *)parent {
    [parent.navigationController popViewControllerAnimated:YES];
    [productos addObjectsFromArray:articulos];
    [tabla reloadData];
}

@end
