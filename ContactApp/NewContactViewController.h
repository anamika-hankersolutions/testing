//
//  NewContactViewController.h
//  ContactApp
//
//  Created by Anamika on 20/11/12.
//  Copyright (c) 2012 Anamika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewContactViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>
{
    
}
@property(strong,nonatomic)IBOutlet UITextField *name,*mobile,*ringtone,*textTone,*company,*address,*email;
@property(strong,nonatomic)IBOutlet UIImageView *imgV;

-(void)alertV:(NSString*)textf;

@end
