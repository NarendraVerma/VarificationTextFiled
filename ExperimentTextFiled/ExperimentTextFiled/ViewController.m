//
//  ViewController.m
//  ExperimentTextFiled
//
//  Created by Narendra Verma on 2/3/14.
//  Copyright (c) 2014 Narendra Verma. All rights reserved.
//
#import "ViewController.h"
#import "ValidationTextFiled.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet ValidationTextFiled *txtValidate;
@property (strong, nonatomic) IBOutlet ValidationTextFiled *text;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
    [self.txtValidate validateWithReturnErrorMessage:^NSString *(UITextField *textFiled, NSString *error) {
        if (!textFiled.text.length) {
            error = @"User name is Empty";
        } else if (textFiled.text.length > 10)
            error = @"ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ";
        return error;
    }];

    [self.text validateWithReturnErrorMessage:^NSString *(UITextField *textFiled, NSString *error) {
        if (!textFiled.text.length) {
            error = @"Require to enter a valid email address";
        }
        return error;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
