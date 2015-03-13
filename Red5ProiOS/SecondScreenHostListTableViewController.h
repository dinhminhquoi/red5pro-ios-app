//
//  SecondScreenHostListTableViewController.h
//  Red5ProiOS
//
//  Created by Todd Anderson on 10/8/14.
//  Copyright (c) 2014 Infrared5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondScreenHostListTableViewController : UITableViewController

-(id) initWithTableView:(UITableView*) tableView andHostView:(UIView *) hostView;

-(void)enable;
-(void)disable;

@end
