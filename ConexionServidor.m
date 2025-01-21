//
//  ConexionServidor.m
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 22/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "ConexionServidor.h"
#import "Constantes.h"
#import "Categorias.h"
#import "Receta.h"

@implementation ConexionServidor

-(NSMutableArray *)dameCategorias {
    @try {
        NSMutableArray *categorias = [[NSMutableArray alloc] init];
        NSString *sUrl = [NSString stringWithFormat:@"%@%@", SERVIDOR, URL_CATEGORIAS];
        NSURL *url = [NSURL URLWithString:sUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSData *requestBody = [@"username:x&password:y" dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:requestBody];
        NSURLResponse *response = NULL;
        
                    NSString *raiz_categorias =@"http://zavordigital.com/la_huerta/";
        
        NSError *requestError = NULL;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
        //NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSArray *readJsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        int j = (int)readJsonArray.count;
        for(int i = 0; i < j; i++) {
           Categorias *c = [[Categorias alloc] init];
          //  NSDictionary *element = readJsonArray[i]; //old style: [readJsonArray objectAtIndex:0]
            NSDictionary *element = readJsonArray[i];
            raiz_categorias = [raiz_categorias stringByAppendingString: element[@"categoria_img"]];
//            element[@"categoria_img"] = raiz_categorias;

            [c fijaIdCategoria: element[@"categoriaid"] nombre:element[@"categoria_nombre"] urlCategoria: raiz_categorias codigo: element[@"categoria_code_tx"] privada:NO];
            
//            NSString *urlCategoria = element[@"categoria_img"];
            
            [categorias addObject:c];
raiz_categorias=@"";
            raiz_categorias=@"http://zavordigital.com/la_huerta/";
            
            //c = [[Categorias alloc] init];
            
        }
        sleep(4);
        return categorias;
    }
    @catch (NSException *exception) {
        return NULL;
    }

}



-(NSMutableArray *)buscaCategorias:(NSString *)criterio {
    @try {
        NSMutableArray *categorias = [[NSMutableArray alloc] init];
        NSString *sUrl = [NSString stringWithFormat:@"%@%@/%@", SERVIDOR, URL_SEARCH_CATEGORY, criterio];
        NSURL *url = [NSURL URLWithString:sUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSData *requestBody = [@"username:x&password:y" dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:requestBody];
        NSURLResponse *response = NULL;
        
        NSString *raiz_categorias =@"http://zavordigital.com/la_huerta/";
        
        NSError *requestError = NULL;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
        //NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSArray *readJsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        int j = (int)readJsonArray.count;
        for(int i = 0; i < j; i++) {
            Categorias *c = [[Categorias alloc] init];
            //  NSDictionary *element = readJsonArray[i]; //old style: [readJsonArray objectAtIndex:0]
            NSDictionary *element = readJsonArray[i];
            raiz_categorias = [raiz_categorias stringByAppendingString: element[@"categoria_img"]];
            //            element[@"categoria_img"] = raiz_categorias;
            
            [c fijaIdCategoria: element[@"categoriaid"] nombre:element[@"categoria_nombre"] urlCategoria: raiz_categorias codigo: element[@"categoria_code_tx"] privada:NO];
            
            //            NSString *urlCategoria = element[@"categoria_img"];
            
            [categorias addObject:c];
            raiz_categorias=@"";
            raiz_categorias=@"http://zavordigital.com/la_huerta/";
            
            //c = [[Categorias alloc] init];
            
        }
        sleep(4);
        return categorias;
    }
    @catch (NSException *exception) {
        return NULL;
    }
    
}

-(NSMutableArray *)buscaReceta:(NSString *)criterio_r {
    @try {
        NSMutableArray *categorias = [[NSMutableArray alloc] init];
        NSString *sUrl = [NSString stringWithFormat:@"%@%@/%@", SERVIDOR, URL_SEARCH_CATEGORY, criterio_r];
        NSURL *url = [NSURL URLWithString:sUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSData *requestBody = [@"username:x&password:y" dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:requestBody];
        NSURLResponse *response = NULL;
        
        NSString *raiz_categorias =@"http://zavordigital.com/la_huerta/";
        
        NSError *requestError = NULL;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
        //NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSArray *readJsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        int j = (int)readJsonArray.count;
        for(int i = 0; i < j; i++) {
            Categorias *c = [[Categorias alloc] init];
            //  NSDictionary *element = readJsonArray[i]; //old style: [readJsonArray objectAtIndex:0]
            NSDictionary *element = readJsonArray[i];
            raiz_categorias = [raiz_categorias stringByAppendingString: element[@"categoria_img"]];
            //            element[@"categoria_img"] = raiz_categorias;
            
            [c fijaIdCategoria: element[@"categoriaid"] nombre:element[@"categoria_nombre"] urlCategoria: raiz_categorias codigo: element[@"categoria_code_tx"] privada:NO];
            
            //            NSString *urlCategoria = element[@"categoria_img"];
            
            [categorias addObject:c];
            raiz_categorias=@"";
            raiz_categorias=@"http://zavordigital.com/la_huerta/";
            
            //c = [[Categorias alloc] init];
            
        }
        sleep(4);
        return categorias;
    }
    @catch (NSException *exception) {
        return NULL;
    }
    
}



-(NSMutableArray *)dameRecetas:(NSString *)idReceta {
    @try {
        NSMutableArray *recetas = [[NSMutableArray alloc] init];
//        idReceta=@"1";
        NSString *sUrl = [NSString stringWithFormat:@"%@%@/%@", SERVIDOR, URL_RECETAS, idReceta];
        NSURL *url = [NSURL URLWithString:sUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSData *requestBody = [@"username:x&password:y" dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:requestBody];
        NSURLResponse *response = NULL;
        
                NSString *raiz_recetas =@"http://zavordigital.com/la_huerta/statics/imagenes_recetas/";
        
        NSError *requestError = NULL;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];

        
        //NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSArray *readJsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        int j = (int)readJsonArray.count;
        for(int i = 0; i < j; i++) {
            Receta *r = [[Receta alloc] init];
//            NSDictionary *element = readJsonArray[i]; //old style: [readJsonArray objectAtIndex:0]
//            concatenar cadena
            NSDictionary *element = readJsonArray[i];
            raiz_recetas = [raiz_recetas stringByAppendingString: element[@"receta_img"]];
//            _categoria
            [r fijaIdReceta:element[@"recetaid"] nombre:element[@"receta_nombre"] porcion:element[@"receta_porcion"] minutos:element[@"receta_tiempo"] votos:element[@"receta_puntuacion"]pasos:element[@"receta_text"] url:raiz_recetas];
            [recetas addObject:r];
            
        
            raiz_recetas=@"";
            raiz_recetas=@"http://zavordigital.com/la_huerta/statics/imagenes_recetas/";
            
        }

        sleep(4);

        return recetas;
    }
    @catch (NSException *exception) {
        return NULL;
    }
}

-(DatosRecetas *)demeDatosRecetas {
    @try {
       
        NSString *sUrl = [NSString stringWithFormat:@"%@%@", SERVIDOR, URL_INGREDIENTES];
        NSURL *url = [NSURL URLWithString:sUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSData *requestBody = [@"username:x&password:y" dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:requestBody];
        NSURLResponse *response = NULL;
        NSError *requestError = NULL;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
        //NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSArray *readJsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        int j = (int)readJsonArray.count;
        for(int i = 0; i < j; i++) {
            NSDictionary *element = readJsonArray[i]; //old style: [readJsonArray objectAtIndex:0]
             DatosRecetas *dr = [[DatosRecetas alloc] init];
//            no hay alojador para  videos
//            final de desarrollo del anterior programador
            NSMutableArray *videos = [[NSMutableArray alloc] init];
            [dr fijaPasoPaso:element[@"ingredienteid"] ingrediente:element[@"ingrediente_nombre"] videos:videos];
            return dr;
//            [DatosRecetas addObject:dr];
            
        }
        /* SOLO PARA PRUEBAS ELIMINAR CUANDO SE ENCUETRE LA API*/
//        sleep(2);

        /*-----------------------------------------------------*/
//
    }
    @catch (NSException *exception) {
        return NULL;
    }
}

@end
