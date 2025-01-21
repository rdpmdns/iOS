//
//  Productos.m
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 20/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "Productos.h"

@implementation Productos

-(void)fijaIdProducto:(NSString *)i nombre:(NSString *)n descripcion:(NSString *)d comprado:(BOOL)c {
    idProducto = i;
    nombre = n;
    descripcion = d;
    comprado = c;
}
-(void)celda_here:(NSString *)here;
{
    idProducto =here;
}

-(NSString *)dameIdProducto{
    return idProducto;
}

-(NSString *)dameNombre {
    return nombre;
}

-(NSString *)dameDescripcion {
    return descripcion;
}

-(BOOL)estaEnLista {
    return comprado;
}

-(void)fijaEstaEnLista:(BOOL)b {
    comprado = b;
}

@end
