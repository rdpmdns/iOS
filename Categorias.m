//
//  Categorias.m
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 22/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "Categorias.h"

@implementation Categorias

-(void)fijaIdCategoria:(NSString *)i nombre:(NSString *)nombre urlCategoria:(NSString *)url codigo:(NSString *)c privada:(BOOL)p {
    idCategoria = i;
    nombreCategoria = nombre;
    urlCategoria = url;
    codigo = c;
    privada = p;
    imgCategoria = NULL;
}

-(void)fijaImagen:(UIImage *)img {
    imgCategoria = img;
}

-(NSString *)dameIdCategoria {
    return idCategoria;
}

-(NSString *)dameNombreCategoria {
    return nombreCategoria;
}

-(NSString *)dameUrlCategoria {
    return urlCategoria;
}

-(NSString *)dameCodigo {
    return codigo;
}

-(UIImage *)dameImagen {
    return imgCategoria;
}

-(BOOL)esPrivada {
    return privada;
}

@end
