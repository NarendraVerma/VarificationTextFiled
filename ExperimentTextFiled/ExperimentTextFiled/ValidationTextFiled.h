//
//  ValidationTextFiled.h
//  ExperimentTextFiled
//
//  Created by Narendra Verma on 2/3/14.
//  Copyright (c) 2014 Narendra Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NSString *(^ErrorMessage)(UITextField * textFiled,NSString * error);

@interface ValidationTextFiled : UITextField
@property (copy, nonatomic) ErrorMessage errorBlock;
@property (assign, nonatomic) BOOL isValide;
- (void) validateWithReturnErrorMessage:(ErrorMessage)errorBlock;

@end
