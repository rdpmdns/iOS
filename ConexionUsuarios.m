//
//  ConexionUsuarios.m
//  La Huerta
//
//  Created by Daniel on 28/03/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "ConexionUsuarios.h"
#import "Constantes.h"

@interface ConexionUsuarios ()

@end

@implementation ConexionUsuarios


-(NSMutableArray *)Reg_user{
    @try {
        NSMutableArray *comentario = [[NSMutableArray alloc] init];
        
        NSString *sUrl = [NSString stringWithFormat:@"%@%@", SERVIDOR, COMENTARIO];
        
        NSURL *url = [NSURL URLWithString:sUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSData *requestBody = [@"username:x&password:y" dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:requestBody];
        NSURLResponse *response = NULL;
        
        NSError *requestError = NULL;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
        
        //        iOS 6.0
        //NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        // Metodo GET regresa codigo de error en red 303
        //        NSArray *readJsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSDictionary *readJsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        
        for ( NSDictionary *evento in readJsonArray ) {
            
            [comentario addObject:evento];
            
        }
        
        sleep(1);
        
        return comentario;
    }
    @catch (NSException *exception) {
        return NULL;
    }
}



-(NSMutableArray *)set_start:(NSString *)id_receta{
    @try {
        NSMutableArray *comentario = [[NSMutableArray alloc] init];
        
        NSString *sUrl = [NSString stringWithFormat:@"%@%@/%@", SERVIDOR, URL_INGREDIENTES, id_receta];
        
        NSURL *url = [NSURL URLWithString:sUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSData *requestBody = [@"username:x&password:y" dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:requestBody];
        NSURLResponse *response = NULL;
        
        NSError *requestError = NULL;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
        
        //        iOS 6.0
        //NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        // Metodo GET regresa codigo de error en red 303
        //        NSArray *readJsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSDictionary *readJsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        
        for ( NSDictionary *evento in readJsonArray ) {
            
            [comentario addObject:evento];
            
        }
        
        sleep(1);
        
        return comentario;
    }
    @catch (NSException *exception) {
        return NULL;
    }
}


-(NSMutableArray *)Get_favorita:(NSString *)id_usuario{
    @try {
        NSMutableArray *comentario = [[NSMutableArray alloc] init];
        
        NSString *sUrl = [NSString stringWithFormat:@"%@%@/%@", SERVIDOR, GET_FAVORITESBYUSER, id_usuario];
        
        NSURL *url = [NSURL URLWithString:sUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSData *requestBody = [@"username:x&password:y" dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:requestBody];
        NSURLResponse *response = NULL;
        
        NSError *requestError = NULL;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
        
        //        iOS 6.0
        //NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        // Metodo GET regresa codigo de error en red 303
        //        NSArray *readJsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSDictionary *readJsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        
        for ( NSDictionary *evento in readJsonArray ) {
            
            [comentario addObject:evento];
            
        }
        
        sleep(1);
        
        return comentario;
    }
    @catch (NSException *exception) {
        return NULL;
    }
}


-(NSMutableArray *)ADD_favoritas:(NSString *)id_receta{
    @try {
        NSMutableArray *comentario = [[NSMutableArray alloc] init];
        
        NSString *sUrl = [NSString stringWithFormat:@"%@%@/%@", SERVIDOR, GET_FAVORITESBYUSER, id_receta];
        
        NSURL *url = [NSURL URLWithString:sUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSData *requestBody = [@"username:x&password:y" dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:requestBody];
        NSURLResponse *response = NULL;
        
        NSError *requestError = NULL;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
        
        //        iOS 6.0
        //NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        // Metodo GET regresa codigo de error en red 303
        //        NSArray *readJsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSDictionary *readJsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        
        for ( NSDictionary *evento in readJsonArray ) {
            
            [comentario addObject:evento];
            
        }
        
        sleep(1);
        
        return comentario;
    }
    @catch (NSException *exception) {
        return NULL;
    }
}


@end
