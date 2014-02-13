//
//  ViewContent.m
//  ExperimentTextFiled
//
//  Created by Narendra Verma on 2/3/14.
//  Copyright (c) 2014 Narendra Verma. All rights reserved.
//
#define BORDER_WIDTH 2.0
#define FONT [UIFont boldSystemFontOfSize:14.0]
#import "ViewContent.h"
@interface ViewContent ()
@property (assign,nonatomic) BOOL showAlert;
@end
@implementation ViewContent

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (id) initWithFrame:(CGRect)frame withErrorMessage:(NSString *)errorMsg {
    self = [super initWithFrame:frame];
    if (self) {
        [self getViewSizeWithText:errorMsg];
        [self setBackgroundColor:[UIColor yellowColor]];
        CGRect rect = self.frame;
        rect.origin.y = -rect.size.height;
        [self setFrame:rect];
        [self showErrorView:YES animated:YES];
        [self performSelector:@selector(hideError) withObject:nil afterDelay:3.0];
        [self setErrorMessage:errorMsg];
    }
    return self;
}

- (void) getViewSizeWithText:(NSString *)errorMsg {
    CGRect rect = self.frame;
    CGSize size = [errorMsg sizeWithFont:FONT
                       constrainedToSize:CGSizeMake(self.frame.size.width - 20, 100)
                           lineBreakMode:NSLineBreakByWordWrapping];
    rect.size.height = size.height + 8;
    [self setFrame:rect];
}

- (void) showError {
    [self showErrorView:YES animated:YES];
}

- (void) showErrorView:(BOOL)show animated:(BOOL)animated {
    CGRect rect = self.frame;
    rect.origin.y = show?0:-rect.size.height;
    [UIView animateWithDuration:(animated?0.5:0.0) animations:^{
        [self setFrame:rect];
    } completion:^(BOOL finished) {
        if (rect.origin.y < 0) {
            [self removeFromSuperview];
        }
    }];
}

- (void) setErrorMessage:(NSString *)message {
    UILabel * lblError = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.bounds.size.width - 10, self.bounds.size.height)];
    [lblError setText:message];
    [lblError setFont:FONT];
    [lblError setTextAlignment:NSTextAlignmentCenter];
    [lblError setLineBreakMode:NSLineBreakByWordWrapping];
    [lblError setBackgroundColor:[UIColor yellowColor]];
    [lblError setNumberOfLines:0];
    [self addSubview:lblError];
}

- (void) hideError {
    [self showErrorView:NO animated:YES];
}

- (void) drawBorderWithRect:(CGRect)rect
                  andradius:(NSInteger)radius
               borderColour:(UIColor *)colour
                borderWidth:(CGFloat)borderWidth {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [colour CGColor]);
    CGContextSetLineWidth(context, borderWidth);

    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + radius);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius);
    CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius,
                    radius, M_PI, M_PI / 2, 1); //STS fixed
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius,
                            rect.origin.y + rect.size.height);
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius,
                    rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + radius);
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius,
                    radius, 0.0f, -M_PI / 2, 1);
    CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y);
    CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius, radius,
                    -M_PI / 2, M_PI, 1);

    CGContextDrawPath(context, kCGPathStroke);
}
@end
