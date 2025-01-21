//
//  UserLogin.h
//  La Huerta
//
//  Created by Daniel on 14/03/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserLogin : UIViewController <UITextFieldDelegate>
{
    
    NSDictionary * CredentialsUser;
    NSMutableData *responseData;
@private
    //    UITextField     *log_ref;
    
}

@property (retain, nonatomic) IBOutlet UITextField  *userNameField;
@property (retain, nonatomic) IBOutlet UITextField  *userEmail;
@property (retain, nonatomic) IBOutlet UITextField  *passwordUserField;
@property (retain, nonatomic) IBOutlet UIView  *fondo;


-(IBAction) EnterLogin;
-(IBAction) EnterFacebook;

-(IBAction)regresar:(id)sender;

@end
