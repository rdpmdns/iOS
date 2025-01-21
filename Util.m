//
//  Util.m
//  TicketingChivas
//
//  Created by Mauricio Uro Martinez on 11/12/13.
//  Copyright (c) 2013 zavordigital. All rights reserved.
//

#import "Util.h"
#import <QuartzCore/QuartzCore.h>

@implementation Util

-(UIView *)creaViewEspera {
    UIView *viewEspera = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    viewEspera.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    UIActivityIndicatorView *indicador = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(8, 0, 80, 80)];
    [indicador startAnimating];
    [viewEspera addSubview:indicador];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 100, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.text = @"Cargando...";
    label.textAlignment = NSTextAlignmentCenter;
    [viewEspera addSubview:label];
    viewEspera.layer.cornerRadius = 10; // this value vary as per your desire
    viewEspera.clipsToBounds = YES;
    return viewEspera;
}

@end
