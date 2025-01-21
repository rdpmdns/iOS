//
//  Receta.m
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 23/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "Receta.h"

@implementation Receta 

-(void)fijaIdReceta:(NSString *)i nombre:(NSString *)nombre porcion:(NSString *)porcion minutos:(NSString *)minutos votos:(NSString *)v pasos:(NSString *)paso_tx url:(NSString *)url{
    idReceta = i;
    nombreReceta = nombre;
    porcionReceta = porcion;
    minutosReceta = minutos;
    votos = v;
    pasos=paso_tx;
    urlImagen = url;
}

-(void)fijaPasos:(NSMutableArray *)p {
    pasos = p;
}

-(void)fijaComentarios:(NSMutableArray *)c {
    comentarios = c;
}

-(NSString *)dameIdReceta {
    return idReceta;
}

-(NSString *)dameNombreReceta {
    return nombreReceta;
}

-(NSString *)damePorcionReceta {
    return porcionReceta;
}

-(NSString *)dameMinutosReceta {
    return minutosReceta;
}

-(NSString *)dameVotos {
    return votos;
}

-(NSMutableArray *)damePasos {
    return pasos;
}

-(NSMutableArray *)dameIngredientes {
    return ingrediente;
}

-(NSMutableArray *)dameComentarios {
    return comentarios;
}

-(NSString *)dameUrlImagen {
    return urlImagen;
}

-(UIImage *)dameImagen {
    return imagenReceta;
}

-(void)fijaImagen:(UIImage *)img {
    imagenReceta = img;
}

@end
