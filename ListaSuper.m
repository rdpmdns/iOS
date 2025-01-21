//
//  ListaSuper.m
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 20/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "ListaSuper.h"

@implementation ListaSuper

-(void)fijaIdLista:(NSString *)i nombre:(NSString *)n {
    idLista = i;
    nombre = n;
}

-(NSString *)dameIdLista {
    return idLista;
}

-(NSString *)dameNombre {
    return nombre;
}

@end
