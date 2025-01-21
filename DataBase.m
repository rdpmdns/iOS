//
//  DataBase.m
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 20/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "DataBase.h"
#import "ListaSuper.h"
#import "Productos.h"

@implementation DataBase

-(void)iniciar {
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
}

-(NSMutableArray *)dameListasSuper {
    NSMutableArray *listas = [[NSMutableArray alloc] init];
    sqlite3 *database;
    sqlite3_stmt *compiledStatement;
    if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *sqlStatement = [NSString stringWithFormat:@"select * from lista"];
        if(sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                NSString *idLista = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                NSString *nombre = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSLog(@"%@", nombre);
                ListaSuper *l = [[ListaSuper alloc] init];
                [l fijaIdLista:idLista nombre:nombre];
                [listas addObject:l];
            }
        } else {
            NSLog(@"%s err: %s", __FUNCTION__, sqlite3_errmsg(database));
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    return listas;
}

-(NSMutableArray *)dameProductosListasSuper:(NSString *)idLista {
    NSMutableArray *productos = [[NSMutableArray alloc] init];
    sqlite3 *database;
    sqlite3_stmt *compiledStatement;
    if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *sqlStatement = [NSString stringWithFormat:@"select t1.id, t2.nombre, t1.comprado FROM productosLista t1 INNER JOIN producto t2 where t1.idProducto = t2.id and t1.idLista = %@", idLista];
        NSLog(@"sql: %@", sqlStatement);
        if(sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                NSString *idProducto = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                NSString *nombre = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSString *comprado = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                BOOL bComprado = NO;
                if ([comprado isEqualToString:@"1"]) {
                    bComprado = YES;
                }
                Productos *p = [[Productos alloc] init];
                [p fijaIdProducto:idProducto nombre:nombre descripcion:@"" comprado:bComprado];
                [productos addObject:p];
            }
        } else {
            NSLog(@"%s err: %s", __FUNCTION__, sqlite3_errmsg(database));
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    
    [self dameProductosLista];
    return productos;
}

-(NSMutableArray *)dameProductos {
    NSMutableArray *productos = [[NSMutableArray alloc] init];
    sqlite3 *database;
    sqlite3_stmt *compiledStatement;
    if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *sqlStatement = [NSString stringWithFormat:@"select * from producto"];
        if(sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                NSString *idProducto = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                NSString *nombre = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSString *descripcion = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSLog(@"%@", nombre);
                Productos *p = [[Productos alloc] init];
                [p fijaIdProducto:idProducto nombre:nombre descripcion:descripcion comprado:NO];
                [productos addObject:p];
            }
        } else {
            NSLog(@"%s err: %s", __FUNCTION__, sqlite3_errmsg(database));
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    return productos;
}

-(NSMutableArray *)dameProductosLista {
    NSMutableArray *productos = [[NSMutableArray alloc] init];
    sqlite3 *database;
    sqlite3_stmt *compiledStatement;
    if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *sqlStatement = [NSString stringWithFormat:@"select * from productosLista"];
        if(sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                NSString *idProducto = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                NSString *nombre = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSString *descripcion = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                NSLog(@"idProducto: %@ -- idLista: %@", nombre, descripcion);
                Productos *p = [[Productos alloc] init];
                [p fijaIdProducto:idProducto nombre:nombre descripcion:descripcion comprado:NO];
                [productos addObject:p];
            }
        } else {
            NSLog(@"%s err: %s", __FUNCTION__, sqlite3_errmsg(database));
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    return productos;
}

-(NSString *)dameMaxIdProductos {
    NSString *result;
    sqlite3 *database;
    sqlite3_stmt *compiledStatement;
    if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *sqlStatement = [NSString stringWithFormat:@"select max(id) from producto"];
        if(sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                result = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
            }
        } else {
            NSLog(@"%s err: %s", __FUNCTION__, sqlite3_errmsg(database));
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    return result;
}

-(NSString *)dameMaxIdLista {
    NSString *result;
    sqlite3 *database;
    sqlite3_stmt *compiledStatement;
    if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *sqlStatement = [NSString stringWithFormat:@"select max(id) from lista"];
        if(sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                result = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
            }
        } else {
            NSLog(@"%s err: %s", __FUNCTION__, sqlite3_errmsg(database));
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    return result;
}


-(NSString *)dameMaxIdProductosLista {
    NSString *result;
    sqlite3 *database;
    sqlite3_stmt *compiledStatement;
    if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *sqlStatement = [NSString stringWithFormat:@"select max(id) from productosLista"];
        if(sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                result = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
            }
        } else {
            NSLog(@"%s err: %s", __FUNCTION__, sqlite3_errmsg(database));
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    return result;
}

-(NSString *)agregaListaSuper:(NSString *)nombre {
    sqlite3 *database;
    sqlite3_stmt *compiledStatement;
    if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *sqlStatement = [NSString stringWithFormat:@"INSERT INTO lista (nombre) VALUES ('%@')",
                                  nombre];
        if(sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
            }
        } else {
            // Puedo informar si ha habido algún error
            NSLog(@"%s err: %s", __FUNCTION__, sqlite3_errmsg(database));
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    return [self dameMaxIdLista];
}

-(NSString *)agregaProductosLista:(NSString *)idProducto idLista:(NSString *)idLista comprado:(NSString *)comprado {
    NSLog(@"idLista: %@", idLista);
    sqlite3 *database;
    sqlite3_stmt *compiledStatement;
    if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *sqlStatement = [NSString stringWithFormat:@"INSERT INTO productosLista (idProducto, idLista, comprado) VALUES ('%@', '%@', '%@')",
                                  idProducto, idLista, comprado];
        if(sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
            }
        } else {
            // Puedo informar si ha habido algún error
            NSLog(@"%s err: %s", __FUNCTION__, sqlite3_errmsg(database));
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    return [self dameMaxIdProductosLista];
}

-(NSString *)agregaProducto:(NSString *)nombre {
    sqlite3 *database;
    sqlite3_stmt *compiledStatement;
    if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *sqlStatement = [NSString stringWithFormat:@"INSERT INTO producto (nombre, descripcion) VALUES ('%@', '')",
                                  nombre];
        if(sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
            }
        } else {
            // Puedo informar si ha habido algún error
            NSLog(@"%s err: %s", __FUNCTION__, sqlite3_errmsg(database));
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    return [self dameMaxIdProductos];
}


-(void) borrarLista:(NSString *)idLista {
    sqlite3 *database;
    sqlite3_stmt *compiledStatement;
    // Abrimos la base de datos de la ruta indicada en el delegate
    if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *sqlStatement = [NSString stringWithFormat:@"DELETE FROM lista WHERE id = '%@'", idLista];
        // Lanzamos la consulta y recorremos los resultados si todo ha ido OK
        if(sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Recorremos los resultados.
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
            }
        } else {
            // Informo si ha habido algún error
            NSLog(@"%s err: %s", __FUNCTION__, sqlite3_errmsg(database));
            
        }
        
        // Libero la consulta
        sqlite3_finalize(compiledStatement);
        
    }
    // Cierro la base de datos
    sqlite3_close(database);
    
}

-(void) borraProductoLista:(NSString *)idLista {
    sqlite3 *database;
    sqlite3_stmt *compiledStatement;
    // Abrimos la base de datos de la ruta indicada en el delegate
    if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *sqlStatement = [NSString stringWithFormat:@"DELETE FROM productosLista WHERE id = '%@'", idLista];
        // Lanzamos la consulta y recorremos los resultados si todo ha ido OK
        if(sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Recorremos los resultados.
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
            }
        } else {
            NSLog(@"%s err: %s", __FUNCTION__, sqlite3_errmsg(database));
            
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}

-(void) borraProducto:(NSString *)idProducto {
    sqlite3 *database;
    sqlite3_stmt *compiledStatement;
    // Abrimos la base de datos de la ruta indicada en el delegate
    if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *sqlStatement = [NSString stringWithFormat:@"DELETE FROM producto WHERE id = '%@'", idProducto];
        // Lanzamos la consulta y recorremos los resultados si todo ha ido OK
        if(sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Recorremos los resultados.
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
            }
        } else {
            NSLog(@"%s err: %s", __FUNCTION__, sqlite3_errmsg(database));
            
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}

-(void)cambiaEstatusProductoLista:(NSString *)idProducto comprado:(NSString *)comprado {
    sqlite3 *database;
    sqlite3_stmt *compiledStatement;
    if(sqlite3_open([appDelegate.databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *sqlStatement = [NSString stringWithFormat:@"UPDATE productosLista SET \"comprado\" = %@ where id = %@", comprado, idProducto];
        if(sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
            }
            
        } else {
            // Informo si ha habido algún error
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}


@end
