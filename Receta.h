//
//  Receta.h
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 23/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Receta : NSObject {
    NSString *idReceta;
    NSString *nombreReceta;
    NSString *porcionReceta;
    NSString *minutosReceta;
    NSString *votos;
    NSMutableArray *pasos;
    NSMutableArray *ingrediente;
    NSMutableArray *comentarios;
    NSString *urlImagen;
    UIImage *imagenReceta;
}

-(void)fijaIdReceta:(NSString *)i nombre:(NSString *)nombre porcion:(NSString *)porcion minutos:(NSString *)minutos votos:(NSString *)v pasos:(NSString *)paso_tx url:(NSString *)url;
-(void)fijaPasos:(NSMutableArray *)p;
-(void)fijaComentarios:(NSMutableArray *)c;
-(NSString *)dameIdReceta;
-(NSString *)dameNombreReceta;
-(NSString *)damePorcionReceta;
-(NSString *)dameMinutosReceta;
-(NSString *)dameVotos;
-(NSMutableArray *)damePasos;
-(NSMutableArray *)dameIngredientes;
-(NSMutableArray *)dameComentarios;
-(NSString *)dameUrlImagen;
-(UIImage *)dameImagen;
-(void)fijaImagen:(UIImage *)img;

@end
