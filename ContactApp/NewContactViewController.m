//
//  NewContactViewController.m
//  ContactApp
//
//  Created by Anamika on 20/11/12.
//  Copyright (c) 2012 Anamika. All rights reserved.
//

#import "NewContactViewController.h"
#import "DBFile.h"

@interface NewContactViewController ()

@end

@implementation NewContactViewController

@synthesize name,mobile,ringtone,textTone,company,address,email,imgV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"New Contact";
    self.navigationItem.leftBarButtonItem.title=@"Cancel";
    
    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(btnSave:)] autorelease];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
-(void)alertV:(NSString*)textf
{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:textf delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField==mobile)
    {
        int l=mobile.text.length;
        if(l<10)
        {
            [self alertV:@"Enter Valid Number"];
        }
    }
    if(textField==email)
    {
        int startRange = [email.text rangeOfString:@"@"].location;
        int endRange = [email.text rangeOfString:@"." options:NSBackwardsSearch].location;
        if(startRange > endRange || startRange==0 || endRange >= email.text.length-2 || endRange+1==startRange)
        {
            [self alertV:@"Enter Valid Email"];
        }
    }
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [name resignFirstResponder];
    [mobile resignFirstResponder];
    [ringtone resignFirstResponder];
    [textTone resignFirstResponder];
    [company resignFirstResponder];
    [address resignFirstResponder];
    [email resignFirstResponder];

}
-(IBAction)btnSave:(id)sender
{
    [[DBFile sharedDatabase]openDatabaseConnection];
    [[DBFile sharedDatabase]insertIntoNewContact:name.text mob:mobile.text mail:email.text comp:company.text rtone:ringtone.text mtone:@"" add:address.text img:imgV.image];
    [[DBFile sharedDatabase]closeDatabaseConnection];
}
@end
