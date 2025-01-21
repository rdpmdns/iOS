//
//  AppDelegate.h
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 20/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSString *databaseName;
	NSString *databasePath;
}

// Variables de la base de datos
@property (nonatomic, retain) NSString *databaseName;
@property (nonatomic, retain) NSString *databasePath;
// Método para iniciar la base de datos y moverla de directorio si es necesario.
-(void)loadDB;
+ (AppDelegate *)sharedAppDelegate;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) NSMutableArray* compartido;
@property (nonatomic) NSDictionary* Lista_ingredientes;


@property (strong, nonatomic) FBSession *session;

@end
