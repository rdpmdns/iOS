//
//  UserLogin.m
//  La Huerta
//
//  Created by Daniel on 14/03/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "UserLogin.h"
#import "AppDelegate.h"
#import "NewComent.h"


@interface UserLogin ()

@end

@implementation UserLogin

@synthesize userNameField, userEmail;
@synthesize passwordUserField, fondo;

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
    userNameField.delegate = self;
    passwordUserField.delegate = self;
    userEmail.delegate = self;
    
    
//      SLAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    
    if (!appDelegate.session.isOpen) {
        // create a fresh session object
        appDelegate.session = [[FBSession alloc] init];
        
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                // we recurse here, in order to update buttons and labels
//                [self updateView];
            }];
        }
    }
	// Do any additional setup after loading the view.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [userNameField resignFirstResponder];
    [passwordUserField resignFirstResponder];
    [userEmail resignFirstResponder];
    
    [UIView beginAnimations:@"BajandoFondo" context:nil];
    [UIView setAnimationDuration:0.3];
    [fondo setFrame:(CGRect){0, 0, fondo.frame.size.width, fondo.frame.size.height}];
    [UIView commitAnimations];
    
    if (textField==userNameField) {
        [userEmail becomeFirstResponder];
    }
    if (textField==userEmail) {
        [passwordUserField becomeFirstResponder];
    }
    else{
        [self EnterLogin];
    }
    
    return YES;
    
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [userNameField resignFirstResponder];
    [userEmail resignFirstResponder];
    [passwordUserField resignFirstResponder];
    
    
    [UIView beginAnimations:@"BajandoFondo" context:nil];
    [UIView setAnimationDuration:0.3];
    [fondo setFrame:(CGRect){0, 0, fondo.frame.size.width, fondo.frame.size.height}];
    [UIView commitAnimations];
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == passwordUserField) {
        [UIView beginAnimations:@"SubiendoFondo" context:nil];
        [UIView setAnimationDuration:0.3];
        [fondo setFrame:(CGRect){0,-140,  fondo.frame.size.width, fondo.frame.size.height}];
        [UIView commitAnimations];
    }
    if (textField == userEmail) {
        [UIView beginAnimations:@"SubiendoFondo" context:nil];
        [UIView setAnimationDuration:0.3];
        [fondo setFrame:(CGRect){0,-140,  fondo.frame.size.width, fondo.frame.size.height}];
        [UIView commitAnimations];
    }
    
}


-(IBAction)regresar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)EnterLogin{
    if ([userNameField.text isEqualToString:@""] || [userEmail.text isEqualToString:@""] || [passwordUserField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Debes ingresar datos validos en los campos con (*)" delegate:self cancelButtonTitle:@"Cerrar" otherButtonTitles:nil];
        [alert show];
    }
    else{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserLogin *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"new_coment"];
    [self.navigationController pushViewController:vc animated:YES];
    }
}

-(IBAction)EnterFacebook{
    // get the app delegate so that we can access the session property
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    // this button's job is to flip-flop the session from open to closed
    if (appDelegate.session.isOpen) {
        // if a user logs out explicitly, we delete any cached token information, and next
        // time they run the applicaiton they will be presented with log in UX again; most
        // users will simply close the app or switch away, without logging out; this will
        // cause the implicit cached-token login to occur on next launch of the application
        
//        log out
        [appDelegate.session closeAndClearTokenInformation];
        
    }
    else {
        if (appDelegate.session.state != FBSessionStateCreated) {
            // Create a new, logged out session.
            appDelegate.session = [[FBSession alloc] init];
        }
        
        // if the session isn't open, let's open it now and present the login UX to the user
        [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                         FBSessionState status,
                                                         NSError *error) {
            // and here we make sure to update our UX according to the new session state
//            [self updateView];
            
        }];
        
    }
    /*
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserLogin *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"new_coment"];
    [self.navigationController pushViewController:vc animated:YES];
    */
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
