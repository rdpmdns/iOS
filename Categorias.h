//
//  Categorias.h
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 22/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Categorias : NSObject {
    NSString *idCategoria;
    NSString *nombreCategoria;
    NSString *urlCategoria;
    UIImage *imgCategoria;
    NSString *codigo;
    BOOL privada;
}

-(void)fijaIdCategoria:(NSString *)i nombre:(NSString *)nombre urlCategoria:(NSString *)url codigo:(NSString *)c privada:(BOOL)p;
-(void)fijaImagen:(UIImage *)img;
-(NSString *)dameIdCategoria;
-(NSString *)dameNombreCategoria;
-(NSString *)dameUrlCategoria;
-(NSString *)dameCodigo;
-(UIImage *)dameImagen;
-(BOOL)esPrivada;

@end
