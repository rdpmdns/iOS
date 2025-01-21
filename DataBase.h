//
//  DataBase.h
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 20/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface DataBase : NSObject {
    AppDelegate *appDelegate;
}

-(void)iniciar;
-(NSMutableArray *)dameListasSuper;
-(NSMutableArray *)dameProductosListasSuper:(NSString *)idLista;
-(NSString *)agregaListaSuper:(NSString *)nombre;
-(void) borrarLista:(NSString *)idLista;
-(NSMutableArray *)dameProductos;
-(void) borraProductoLista:(NSString *)idLista;
-(NSString *)agregaProducto:(NSString *)nombre;
-(void) borraProducto:(NSString *)idProducto;
-(NSString *)agregaProductosLista:(NSString *)idProducto idLista:(NSString *)idLista comprado:(NSString *)comprado;
-(void)cambiaEstatusProductoLista:(NSString *)idProducto comprado:(NSString *)comprado;

@end
