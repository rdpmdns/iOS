//
//  InstruccionesContenido.m
//  La Huerta
//
//  Created by Daniel on 12/03/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "InstruccionesContenido.h"
#import "ConexionInstrucciones.h"
#import "Util.h"
#import "AppDelegate.h"


@interface InstruccionesContenido () {
    NSMutableArray *TemasTips;
    UIView *viewEspera;
    NSString *nombreTip;
    NSString *idTip;
}

@end

@implementation InstruccionesContenido
@synthesize AddList;
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
    tabla_v2.dataSource = self;
    tabla_v2.delegate = self;
    Util *u = [[Util alloc] init];
    viewEspera = [u creaViewEspera];
    viewEspera.center = self.view.center;
    [self.view addSubview:viewEspera];
    
    Instruc = [AppDelegate sharedAppDelegate].compartido;
    idTip = [Instruc objectForKey:@"instruccionid"];
    label_instruccion.text = [Instruc objectForKey:@"instruccion_nombre"];
    
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

-(void)fijaTituloTip:(NSString *)c idTip:(NSString *)i {
    nombreTip= c;
    idTip = i;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return AddList.count;
}



-(void)descargarTemasTips {
    
//    static NSString *Cellop = @"desc";
//    
//    UITextView *descrip_l = (UITextView *)[ viewWithTag:11];
    
    [self performSelectorOnMainThread:@selector(terminaDescargaTemasTips) withObject:nil waitUntilDone:NO];

}

-(void)terminaDescargaTemasTips {
    viewEspera.hidden = YES;
    if ([Instruc objectForKey:@"instruccion_descrip"] == NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Hay conexion a Internet o no hay Clientes." message:@"Revise su conexión a internet." delegate:nil cancelButtonTitle:@"Cerrar" otherButtonTitles: nil];
        [alert show];
    } else {
        
        sleep(1);
        
        descrip_l.text = [NSString stringWithFormat: @"%@", [Instruc objectForKey:@"instruccion_descrip"]];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tabla_v2 == nil) {
        static NSString *CellIdentifier = @"desc";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"desc";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        UITextView *descrip_l = (UITextView *)[cell viewWithTag:11];
        
        NSDictionary* evento  = [self.AddList objectAtIndex:indexPath.row];
        sleep(1);
        
//        descrip_l.text = [NSString stringWithFormat: @"%@", [evento objectForKey:@"instruccion_descrip"]];
        return cell;
    }
}

@end