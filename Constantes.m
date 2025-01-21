//
//  Constantes.m
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 22/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "Constantes.h"

@implementation Constantes

NSString * const SERVIDOR = @"http://zavordigital.com/la_huerta/index.php/mobiles/";
NSString * const URL_CATEGORIAS = @"GetAllCategories";
NSString * const URL_RECETAS = @"GetAllRecipesByCategory";
NSString * const URL_INGREDIENTES = @"GetAllIngredientsByRecipe";
NSString * const URL_INSTRUCCIONES = @"GetAllInstruccions";
NSString * const URL_COMENTARIOS = @"GetAllComentsByRecipe";
NSString * const URL_SEARCH_RECIPE=@"GetSearchRecipe";
NSString * const URL_SEARCH_CATEGORY=@"GetSearchCategory";
NSString * const URL_VIDEOS = @"GetAllVideosByRecipe";
NSString * const URL_VIDEOS_INS = @"GetAllVideosByInstruccion";

NSString * const URL_SEARCH_Instruccion = @"GetSearchInstruccion";

NSString * const INSTRUCCIONES =@"GetAllInstruccions";


NSString * const COMENTARIO =@"GetAllComentsByRecipe";
NSString * const SAVE_COMENTARIO=@"AddComentByRecipe";


NSString * const ESTADISTICA_User=@"";
NSString * const ESTADISTICA_RECETA=@"";
NSString * const REG_USER=@"";
NSString * const ADD_FAVORITESBYUSER=@"";
NSString * const GET_FAVORITESBYUSER=@"";


@end
