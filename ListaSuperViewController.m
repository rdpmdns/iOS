//
//  ListaSuperViewController.m
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 20/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "ListaSuperViewController.h"
#import "DataBase.h"
#import "ListaSuper.h"
#import <QuartzCore/QuartzCore.h>
#import "ListaArticulosViewController.h"

@interface ListaSuperViewController () {
    DataBase *dataBase;
    NSMutableArray *listas;
    UIView *viewAgregaProducto;
    UITextField *nombre;
}

@end

@implementation ListaSuperViewController

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
    [self.navigationController setNavigationBarHidden:YES];
    dataBase = [[DataBase alloc] init];
    [dataBase iniciar];
    listas = [dataBase dameListasSuper];
    tabla.dataSource = self;
    tabla.delegate = self;
    tabla.backgroundColor = [UIColor clearColor];
    tabla.separatorColor = [UIColor clearColor];
    [self creaViewAgregaProducto];
    UISwipeGestureRecognizer* rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(izquierda)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [tabla addGestureRecognizer:rightSwipeGestureRecognizer];
    UISwipeGestureRecognizer* leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(derecha)];
    leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [tabla addGestureRecognizer:leftSwipeGestureRecognizer];
}

-(void)derecha {
    [tabla setEditing:YES animated:YES];
}

-(void)izquierda {
    [tabla setEditing:NO animated:YES];
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
    return [listas count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ListaSuper *l = [listas objectAtIndex:indexPath.row];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListaArticulosViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"listaArticulos"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [vc fijaIdLista:[l dameIdLista]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    UIImageView *flecha = nil;
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
        flecha = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next.png"]];
        flecha.frame = CGRectMake(285, 10, 15, 25);
        flecha.tag = 100;
        linea = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, 280, 3)];
        linea.image = [UIImage imageNamed:@"linea.png"];
        linea.tag = 102;
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:flecha];
        [cell.contentView addSubview:linea];
    } else {
        flecha = ((UIImageView *) [cell.contentView viewWithTag:100]);
        label = ((UILabel *) [cell.contentView viewWithTag:101]);
        linea = ((UIImageView *) [cell.contentView viewWithTag:102]);
    }
    cell.backgroundColor = [UIColor clearColor];
    ListaSuper *l = [listas objectAtIndex:indexPath.row];
    label.text = [l dameNombre];
    return cell;
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
    nombre.placeholder = @"Nombre de la lista";
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ingrese el nombre de la lista." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else {
        NSString *idLista = [dataBase agregaListaSuper:nombre.text];
        ListaSuper *l = [[ListaSuper alloc] init];
        [l fijaIdLista:idLista nombre:nombre.text];
        [listas addObject:l];
        [tabla reloadData];
        viewAgregaProducto.hidden = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lista agregada con éxito." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

-(IBAction)nuevaLista:(id)sender {
    if (viewAgregaProducto.isHidden) {
        viewAgregaProducto.hidden = NO;
    } else {
        viewAgregaProducto.hidden = YES;
    }
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
    ListaSuper *l = [listas objectAtIndex:f];
    [listas removeObjectAtIndex:f];
    [tabla reloadData];
    [dataBase borrarLista:[l dameIdLista]];
}

@end
