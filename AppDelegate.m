//
//  AppDelegate.m
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 20/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import "AppDelegate.h"
#import "UserLogin.h"

@implementation AppDelegate

@synthesize databaseName, databasePath, compartido;


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:self.session];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIImage* tabBarBackground = [UIImage imageNamed:@"fondo_tab.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    // Let the device know we want to receive push notifications
	/*[[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];*/
    // Ruta para la base de datos. Estará en Library que es privada, ya que Documents se comparte con el usuario mediante iTunes.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    compartido=  [[NSMutableArray alloc] initWithCapacity:0];
    
    // Añadimos el nombre del fichero de base de datos.
    self.databasePath = [documentsDirectory stringByAppendingPathComponent:@"huerta.sqlite"];
    NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
    [userPreferences setObject:self.databasePath forKey:@"pathdb"];
    // Cargo la base de datos
    [self loadDB];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBAppEvents activateApp];
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    // FBSample logic
    // We need to properly handle activation of the application with regards to SSO
    //  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBAppCall handleDidBecomeActiveWithSession:self.session];

}

+ (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *) [UIApplication sharedApplication].delegate;
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.session close];
}


-(void)loadDB
{
    BOOL exito;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [libraryDirectory stringByAppendingPathComponent:@"huerta.sqlite"];
    exito = [fileManager fileExistsAtPath:writableDBPath];
    if (exito) return;
    // Si no existe en Library, la copio desde el original.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"huerta.sqlite"];
    exito = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!exito) {
        NSAssert1(0, @"Error al cargar la base de datos, error = '%@'.", [error localizedDescription]);
    }
    
}


- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString *token = [[[[deviceToken description]
                         stringByReplacingOccurrencesOfString: @"<" withString: @""]
                        stringByReplacingOccurrencesOfString: @">" withString: @""]
                       stringByReplacingOccurrencesOfString: @" " withString: @""];
    @try {
        NSLog(@"Token: %@", token);
        [self registrarUsuarioServidor:token];
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
}

-(void) registrarUsuarioServidor: (NSString *)token {
    @try {
        NSString *value= [[NSUserDefaults standardUserDefaults] stringForKey:@"idweb"];
        if(value == NULL) {
            value = [NSString stringWithFormat:@"-1"];
        }
        NSLog(@"%@", value);
        NSString *aux = [NSString stringWithFormat:@"http://www.zavordigital.com/costillas_de_sancho/inicio.php/mobiles/RegisterUserPlatform/%@", value];
        NSURL *url = [NSURL URLWithString:aux];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSMutableData *requestBody = [NSMutableData data];
        [requestBody appendData:[[NSString stringWithFormat:@"token=%@&dispositivo=%@", token, @"IOS"]dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:requestBody];
        NSURLResponse *response = NULL;
        NSError *requestError = NULL;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
        [userPreferences setObject:responseString forKey:@"idweb"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"%@", responseString);
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
}


- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
}

@end
