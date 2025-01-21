//
//  Productos.h
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 20/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Productos : NSObject {
    NSString *idProducto;
    NSString *nombre;
    NSString *descripcion;
    BOOL comprado;
}

-(void)fijaIdProducto:(NSString *)i nombre:(NSString *)n descripcion:(NSString *)d comprado:(BOOL)c;

-(void)celda_here:(NSString *)here;

-(NSString *)dameIdProducto;
-(NSString *)dameNombre;
-(NSString *)dameDescripcion;
-(BOOL)estaEnLista;
-(void)fijaEstaEnLista:(BOOL)b;

@end
