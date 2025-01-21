//
//  DatosRecetas.m
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 31/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "DatosRecetas.h"

@implementation DatosRecetas

-(void)fijaPasoPaso:(NSString *)pp ingrediente:(NSString *)i videos:(NSMutableArray *)v {
    pasoPaso = pp;
    ingredientes = i;
    videos = v;
}

-(NSString *)damePasoPaso {
    return pasoPaso;
}

-(NSString *)dameIngredientes {
    return ingredientes;
}

-(NSMutableArray *)dameVideos {
    return videos;
}

@end
