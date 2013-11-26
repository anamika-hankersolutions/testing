//
//  DBFile.m
//  ContactApp
//
//  Created by Anamika on 20/11/12.
//  Copyright (c) 2012 Anamika. All rights reserved.
//

#import "DBFile.h"
#define DatabaseName @"ContactAppDB.sqlite"

@implementation DBFile

static DBFile*	singleton;
+(DBFile*) sharedDatabase
{
	if (!singleton)
	{
		singleton = [[DBFile alloc] init];
	}
	return singleton;
}


+ (sqlite3*) getNewDBConnection
{
	sqlite3 *newDBconnection;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [[paths objectAtIndex:0]stringByAppendingPathComponent:@"DataBase"];
	
	NSString *path = [documentsDirectory stringByAppendingPathComponent:DatabaseName];
	// Open the database. The database was prepared outside the application.
	if (sqlite3_open([path UTF8String], &newDBconnection) == SQLITE_OK)
	{
		NSLog(@"Database Successfully Opened :)");
	}
	else
	{
		NSLog(@"Error in opening database :(");
	}
	return newDBconnection;
}


-(void)dealloc
{
	[super dealloc];
}


+(NSString*) WritableDBPath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [[paths objectAtIndex:0]stringByAppendingPathComponent:@"DataBase"];
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:false attributes:nil error:nil];
	
	return [documentsDirectory stringByAppendingPathComponent:DatabaseName];
}

- (void)createEditableCopyOfDatabaseIfNeeded
{
	NSLog(@"Creating editable copy of database");
	
	// First, test for existence.
	NSString *writableDBPath = [DBFile WritableDBPath];
	NSLog(@"%@",writableDBPath);
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if ([fileManager fileExistsAtPath:writableDBPath])
	{
        return;
    }
	// The writable database does not exist, so copy the default to the appropriate location.
	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DatabaseName];
	NSError *error;
	if (![fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error])
	{
		NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}

- (void) openDatabaseConnection
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [[paths objectAtIndex:0]stringByAppendingPathComponent:@"DataBase"];;
	NSString *path = [documentsDirectory stringByAppendingPathComponent:DatabaseName];
	// Open the database. The database was prepared outside the application.
	if (sqlite3_open([path UTF8String], &dataBaseConnection) == SQLITE_OK)
	{
		NSLog(@"Database Successfully Opened :)");
	}
	else
	{
		NSLog(@"Error in opening database :(");
	}
	
}

- (void) closeDatabaseConnection
{
	sqlite3_close(dataBaseConnection);
	NSLog(@"Database Successfully Closed :)");
}


-(void)insertIntoNewContact:(NSString*)name mob:(NSString*)mobile mail:(NSString*)email comp:(NSString*)company rtone:(NSString*)ringtone mtone:(NSString*)msgtone add:(NSString*)address img:(UIImage *)image
{
    sqlite3_stmt *addStmt = nil;
    NSString *query;
    query = @"INSERT INTO NewContact(name,mobile,email,company,ringtone,msgtone,address,image) VALUES (?,?,?,?,?,?,?,?)";
    const char *sql = [query cStringUsingEncoding:NSUTF8StringEncoding];
    
    
    if (sqlite3_prepare_v2(dataBaseConnection, sql, -1, &addStmt, NULL) != SQLITE_OK)
    {
        NSLog(0,@"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(dataBaseConnection));
    }
    
    const char*	dname = [name UTF8String];
    sqlite3_bind_text(addStmt,1, dname, -1, SQLITE_TRANSIENT);
    
    const char*	dmob = [mobile UTF8String];
    sqlite3_bind_text(addStmt,2, dmob, -1, SQLITE_TRANSIENT);
    
    const char*	dmail = [email UTF8String];
    sqlite3_bind_text(addStmt,3,dmail, -1, SQLITE_TRANSIENT);
    
    const char*	dcomp = [company UTF8String];
    sqlite3_bind_text(addStmt,4, dcomp, -1, SQLITE_TRANSIENT);
    
    const char*	drtone = [ringtone UTF8String];
    sqlite3_bind_text(addStmt,5, drtone, -1, SQLITE_TRANSIENT);
    
    const char*	dmtone = [msgtone UTF8String];
    sqlite3_bind_text(addStmt,6, dmtone, -1, SQLITE_TRANSIENT);
    
    const char*	dadd = [address UTF8String];
    sqlite3_bind_text(addStmt,7, dadd, -1, SQLITE_TRANSIENT);
    
    UIImage *wordImage = image;
	if (wordImage != nil)
	{
		NSData *image = UIImagePNGRepresentation(wordImage);
		sqlite3_bind_blob(addStmt,8, [image bytes],[image length], NULL);
	}
	else
	{
		sqlite3_bind_blob(addStmt , 1 , nil , -1 , NULL);
	}
    
    
    if(SQLITE_DONE != sqlite3_step(addStmt))
        
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(dataBaseConnection));
    sqlite3_finalize(addStmt);

}
@end
