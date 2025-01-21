//
//  ConexionComentarios.h
//  La Huerta
//
//  Created by Daniel on 12/03/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ConexionComentarios : UIViewController


-(NSMutableArray *)GetComent:(NSString *)id_receta;
-(NSMutableArray *)getIngredientes:(NSString *)id_receta;

@end