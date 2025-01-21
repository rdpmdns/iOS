//
//  ConexionServidor.h
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 22/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatosRecetas.h"

@interface ConexionServidor : NSObject {
    
}

-(NSMutableArray *)dameCategorias;
-(NSMutableArray *)buscaCategorias:(NSString*)criterio;
-(NSMutableArray *)buscaReceta:(NSString *)criterio_r;
-(NSMutableArray *)dameRecetas:(NSString *)idReceta;
-(DatosRecetas *)demeDatosRecetas;

@end
