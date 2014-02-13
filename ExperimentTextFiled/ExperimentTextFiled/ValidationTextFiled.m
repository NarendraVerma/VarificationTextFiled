//
//  ValidationTextFiled.m
//  ExperimentTextFiled
//
//  Created by Narendra Verma on 2/3/14.
//  Copyright (c) 2014 Narendra Verma. All rights reserved.
//

#import "ValidationTextFiled.h"
#import "ViewContent.h"
#import <QuartzCore/QuartzCore.h>

#define ERROR_DURATION 0.4
@interface ValidationTextFiled () {
    UIButton * btnEx;
}
@property (strong, nonatomic) UIView * vwError;
@property (strong, nonatomic) UILabel * lblErrorMsg;
@property (assign, nonatomic) id <UITextFieldDelegate> superDelegate;
@end

@implementation ValidationTextFiled


#pragma mark - 

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            [self initPopupView];
            [self initErrorLabel];
//            [self buttons];
            [self buttonEx];
        });
    }
    return self;
}

- (void) buttonEx {
    btnEx = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnEx setFrame:self.lblErrorMsg.frame];
    [btnEx setImage:[UIImage imageNamed:@"error"] forState:UIControlStateNormal];
    [btnEx addTarget:self action:@selector(requiretoBecomeFirstResponder) forControlEvents:UIControlEventTouchUpInside];
    [btnEx setFrame:CGRectMake(self.bounds.size.width - 40,0, 40, 40)];
    [btnEx setCenter:CGPointMake(btnEx.center.x, (self.bounds.size.height + 3)/2)];
    [btnEx setTransform:CGAffineTransformMakeScale(0.0, 0.0)];
}

- (void) showError {
    [self addSubview:btnEx];
    [UIView animateWithDuration:0.33 animations:^{
        [btnEx setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            [btnEx setTransform:CGAffineTransformMakeScale(0.8, 0.8)];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                [btnEx setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
            }];
        }];
    }];
}


- (void) hideError {
    [UIView animateWithDuration:0.33 animations:^{
        [btnEx setTransform:CGAffineTransformMakeScale(0.0, 0.0)];
    } completion:^(BOOL finished) {
        [btnEx removeFromSuperview];
    }];
}

- (void) initPopupView {
    self.vwError =  [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width, 0, 200, 30)];
    [self.vwError setCenter:CGPointMake(self.vwError.center.x, self.center.y)];
    [self.vwError setBackgroundColor:[UIColor redColor]];
    [self.vwError.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.vwError.layer setBorderWidth:1.0f];
    [self.vwError.layer setCornerRadius:5.0f];
    [self.vwError setAlpha:0.0];
    [self.vwError.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.vwError.layer setShadowRadius:5.0f];
    [self.vwError.layer setShadowOpacity:0.75f];
    [self.superview addSubview:self.vwError];
}



- (void) buttons {
    UIButton * btnFirstResponder = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFirstResponder setFrame:self.lblErrorMsg.frame];
    [btnFirstResponder addTarget:self action:@selector(requiretoBecomeFirstResponder) forControlEvents:UIControlEventTouchUpInside];
    [self.vwError addSubview:btnFirstResponder];

    UIButton * btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
   [btnClose setFrame:CGRectMake(self.vwError.frame.size.width - self.vwError.bounds.size.height,
                                 0,
                                 self.vwError.bounds.size.height,
                                 self.vwError.bounds.size.height)];
   [btnClose setCenter:CGPointMake(btnClose.center.x, self.vwError.bounds.size.height/2)];
   [btnClose addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
   [self.vwError addSubview:btnClose];
}

- (void) requiretoBecomeFirstResponder {
    ViewContent * viewC = [[ViewContent alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        self.superview.bounds.size.width,
                                                                        60) withErrorMessage:self.lblErrorMsg.text];
    [self.superview addSubview:viewC];
}

- (void) initErrorLabel {
    UILabel * lblError = [[UILabel alloc] initWithFrame:CGRectMake(0,0, self.vwError.bounds.size.width - 20,self.vwError.bounds.size.height - 6)];
    [lblError setBackgroundColor:[UIColor clearColor]];
    [lblError setFont:[UIFont boldSystemFontOfSize:10.0f]];
    [lblError setCenter:CGPointMake(self.vwError.bounds.size.width/2, self.vwError.bounds.size.height/2)];
    self.lblErrorMsg = lblError;
    [self.vwError addSubview:lblError];
}

#pragma mark - Notofication

- (BOOL) becomeFirstResponder {
    [self hideError];
    return [super becomeFirstResponder];
}

- (BOOL) resignFirstResponder {
    [self checkForValidation];
    return [super resignFirstResponder];
}
#pragma mark - Animation

- (void) close {

    [UIView animateWithDuration:ERROR_DURATION animations:^{
        [self showErrorView:NO];
    }];
}

- (void) animateErrorMessageView {
    [UIView animateWithDuration:ERROR_DURATION animations:^{
        [self showErrorView:YES];
    }];
}

- (void) showErrorView:(BOOL) show {
    CGRect rect = self.vwError.frame;
    rect.origin.x = self.bounds.size.width - ((show)?(rect.size.width):0.0);
    [self.vwError setAlpha:show];
    [self.vwError setFrame:rect];
}

#pragma mark - Validation
- (void) checkForValidation {
    if (self.errorBlock) {
        self.lblErrorMsg.text = self.errorBlock(self,@"");
        if (self.lblErrorMsg.text.length) {
            [self showError];
            self.isValide = NO;
        } else {
            self.isValide = YES;
        }
    }
}

- (void) validateForEmpty {

}

- (void) validateWithReturnErrorMessage:(ErrorMessage)errorBlock {
    self.errorBlock = errorBlock;
}
@end
