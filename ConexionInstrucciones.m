//
//  ConexionInstrucciones.m
//  La Huerta
//
//  Created by Daniel on 12/03/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "ConexionInstrucciones.h"
#import "Constantes.h"

@interface ConexionInstrucciones ()

@end

@implementation ConexionInstrucciones

-(NSMutableArray *)GetInstrucciones{
    @try{
        NSMutableArray *instruccion = [[NSMutableArray alloc] init];
        NSString *sUrl = [NSString stringWithFormat:@"%@%@", SERVIDOR, INSTRUCCIONES];
        NSURL *url = [NSURL URLWithString:sUrl];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSData *requestBody = [@"username:x&password:y" dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:requestBody];
        NSURLResponse *response = NULL;
        NSError *requestError = NULL;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
        //NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]; //ios 6.0
        NSArray *readJsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        int j = (int)readJsonArray.count;
        for(int i = 0; i < j; i++) {
            NSDictionary *element = readJsonArray[i];
            
            [instruccion addObject:element];
            
        }
        sleep(1);
        
        return instruccion;
    }
    @catch (NSException *exception) {
        return NULL;
    }
    
    
}



-(NSMutableArray *)GetShowTips:(NSString *)idTip{
    @try {
        NSMutableArray *TemasTips = [[NSMutableArray alloc] init];
        
        NSString *sUrl = [NSString stringWithFormat:@"%@%@/%@", SERVIDOR,INSTRUCCIONES, idTip];
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
            NSDictionary *element = readJsonArray[i];
            
            [TemasTips addObject:element];

            
            
        }
        sleep(1);
        
        return TemasTips;
    }
    @catch (NSException *exception) {
        return NULL;
    }
}



-(NSMutableArray *)SearchInstruc:(NSString *)name{
    @try {
        NSMutableArray *TemasTips = [[NSMutableArray alloc] init];
        
        NSString *sUrl = [NSString stringWithFormat:@"%@%@/%@", SERVIDOR,URL_SEARCH_Instruccion, name];
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
            NSDictionary *element = readJsonArray[i];
            
            [TemasTips addObject:element];
            
            
            
        }
        sleep(1);
        
        return TemasTips;
    }
    @catch (NSException *exception) {
        return NULL;
    }
}



@end
