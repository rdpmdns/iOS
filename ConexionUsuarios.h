//
//  ConexionUsuarios.h
//  La Huerta
//
//  Created by Daniel on 28/03/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ConexionUsuarios : UIViewController


-(NSMutableArray *)Reg_user;
-(NSMutableArray *)set_start:(NSString *)id_receta;
-(NSMutableArray *)Get_favorita:(NSString *)id_usuario;
-(NSMutableArray *)ADD_favoritas:(NSString *)id_receta;
@end