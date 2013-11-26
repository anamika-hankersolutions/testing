//
//  DBFile.h
//  ContactApp
//
//  Created by Anamika on 20/11/12.
//  Copyright (c) 2012 Anamika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import <UIKit/UIKit.h>

@interface DBFile : NSObject
{
    sqlite3 *dataBaseConnection;
}

+(DBFile*)sharedDatabase;


-(void) createEditableCopyOfDatabaseIfNeeded;
-(void) openDatabaseConnection ;
-(void) closeDatabaseConnection;

-(void)insertIntoNewContact:(NSString*)name mob:(NSString*)mobile mail:(NSString*)email comp:(NSString*)company rtone:(NSString*)ringtone mtone:(NSString*)msgtone add:(NSString*)address img:(UIImage *)image;

@end
