//
//  ContactAppAppDelegate.h
//  ContactApp
//
//  Created by Anamika on 20/11/12.
//  Copyright (c) 2012 Anamika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactAppAppDelegate : UIResponder <UIApplicationDelegate>
{
    
}

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnNewContact;
@property (strong, nonatomic) IBOutlet UITableView *tableV;
@end
