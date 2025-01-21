//
//  ListaSuper.h
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 20/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListaSuper : NSObject {
    NSString *idLista;
    NSString *nombre;
}

-(void)fijaIdLista:(NSString *)i nombre:(NSString *)n;
-(NSString *)dameIdLista;
-(NSString *)dameNombre;

@end
