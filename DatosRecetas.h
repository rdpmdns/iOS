//
//  DatosRecetas.h
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 31/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatosRecetas : NSObject {
    NSString *pasoPaso;
    NSString *ingredientes;
    NSMutableArray *videos;
}

-(void)fijaPasoPaso:(NSString *)pp ingrediente:(NSString *)i videos:(NSMutableArray *)v;
-(NSString *)damePasoPaso;
-(NSString *)dameIngredientes;
-(NSMutableArray *)dameVideos;

@end
