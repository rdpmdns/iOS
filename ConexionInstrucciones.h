//
//  ConexionInstrucciones.h
//  La Huerta
//
//  Created by Daniel on 12/03/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConexionInstrucciones : UIViewController


-(NSMutableArray *)GetInstrucciones;
-(NSMutableArray *)GetShowTips:(NSString *)idTip;
-(NSMutableArray *)SearchInstruc:(NSString *)name;


@end
