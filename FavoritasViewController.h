//
//  FavoritasViewController.h
//  La Huerta
//
//  Created by Mauricio Uro Martinez on 20/01/14.
//  Copyright (c) 2014 zavordigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritasViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *tabla_favoritas;
}

@property (strong, nonatomic) NSMutableArray *FavoritasList;

@end
