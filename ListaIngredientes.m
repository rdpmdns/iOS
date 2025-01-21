//
//  ListaIngredientes.m
//  La Huerta
//
//  Created by Daniel on 24/03/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "ListaIngredientes.h"
#import "AppDelegate.h"
#import "VisorRecetaViewController.h"
#import "Util.h"


@interface ListaIngredientes (){
    int *x;
}

@end

@implementation ListaIngredientes
@synthesize ingrediente_add;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
- (void)viewDidLoad
{
    [super viewDidLoad];
    x=1;
    tabla_lista.dataSource = self;
    tabla_lista.delegate = self;
    
    self.ingrediente_add = [[NSMutableArray alloc] initWithCapacity:0];
    [self.navigationController setNavigationBarHidden:YES];
    
    ingrediente_add = [AppDelegate sharedAppDelegate].compartido;

//    [ingrediente_add addObject:[AppDelegate sharedAppDelegate].compartido];
    
    [self performSelectorOnMainThread:@selector(terminaDescargaIngredientes) withObject:nil waitUntilDone:NO];
	// Do any additional setup after loading the view.
}*/


-(IBAction)Limpiar:(id)sender{
    ingrediente_add =nil;
    [AppDelegate sharedAppDelegate].compartido=nil;
    
    [self performSelectorOnMainThread:@selector(limpia_ingredientes) withObject:nil waitUntilDone:NO];
}


-(void)viewWillAppear:(BOOL)animated {
     [super viewWillAppear:animated];
    x=1;
    tabla_lista.dataSource = self;
    tabla_lista.delegate = self;
    
    self.ingrediente_add = [[NSMutableArray alloc] initWithCapacity:0];
    [self.navigationController setNavigationBarHidden:YES];
    
    ingrediente_add = [AppDelegate sharedAppDelegate].compartido;
    
    //    [ingrediente_add addObject:[AppDelegate sharedAppDelegate].compartido];
    
    [self performSelectorOnMainThread:@selector(terminaDescargaIngredientes) withObject:nil waitUntilDone:NO];
	// Do any additional setup after loading the view.
    
}
/*
-(void)viewDidAppear{
    ingrediente_add =Nil;
    ingrediente_add = [AppDelegate sharedAppDelegate].compartido;
    [self performSelectorOnMainThread:@selector(terminaDescargaIngredientes) withObject:nil waitUntilDone:NO];
}*/


-(IBAction)ingredient_select:(id)sender{
    if (x==1) {
        [sender setImage:[UIImage imageNamed:@"circulo2.png"] forState:normal];
        x=2;
        
    }
    else{
        [sender setImage:[UIImage imageNamed:@"circulo1.png"] forState:normal];
        x=1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ingrediente_add.count;
}

-(void)terminaDescargaIngredientes {
//    viewEspera.hidden = YES;
    
//    self.ingrediente_add = [[NSMutableArray alloc] initWithCapacity:0];
    if (ingrediente_add == NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lista de ingredientes vacia." message:@"Añade ingredientes del recetario" delegate:nil cancelButtonTitle:@"Cerrar" otherButtonTitles: nil];
        [alert show];
    } else {
        
        [tabla_lista reloadData];
        
    }
}


-(void)limpia_ingredientes {
        [tabla_lista reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ingrediente_nombre";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel *ingrediente_l = (UILabel *)[cell viewWithTag:13];
    UIButton *ingrediente_b = (UIButton *)[cell viewWithTag:12];
    
    NSDictionary* evento  = [self.ingrediente_add objectAtIndex:indexPath.row];
    
    ingrediente_l.text = [evento objectForKey:@"ingrediente_nombre"];
    [ingrediente_b addTarget:self action:@selector(ingredient_select:)
           forControlEvents:UIControlEventTouchUpInside];
    
    //NSString* eventFoto = [NSString stringWithFormat:@"%@%@", ServerAddStatic,[evento objectForKey:@"eventoPathImg"]];
    //img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:eventFoto]]];
    
    return cell;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
