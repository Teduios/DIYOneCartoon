//
//  CCSelectedImage.m
//  CrazyCartoon
//
//  Created by Tarena on 16/4/25.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CCSelectedImage.h"

#define kSPUserResizableViewInteractiveBorderSize 10.0

@interface CCSelectedImage()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPinchGestureRecognizer* pinch;
@property (nonatomic, strong) UITapGestureRecognizer* tap;
@property (nonatomic, strong) UIPanGestureRecognizer* pan;


@end

@implementation CCSelectedImage

-(instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    self.frame = CGRectMake(0, 100, 50, 50);
    
    _pinch= [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:_pinch];
    [self addGestureRecognizer:_tap];
    [self addGestureRecognizer:_pan];
    self.pinch.delegate = self;
    self.tap.delegate = self;
    self.pan.delegate = self;
    
    self.multipleTouchEnabled = YES;
    [self setUserInteractionEnabled:YES];
    
    return self;
}
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextAddRect(context, CGRectInset(self.bounds, kSPUserResizableViewInteractiveBorderSize/2, kSPUserResizableViewInteractiveBorderSize/2));
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
}


-(void)reset
{
    self.transform = CGAffineTransformIdentity;
    
}

#pragma mark - 手势设置
- (void)pan:(UIPanGestureRecognizer *)sender {
    
    [self.superview bringSubviewToFront:self];
    CGPoint translation = [sender translationInView:self];
    self.transform =CGAffineTransformTranslate(self.transform, translation.x, translation.y);
    [sender setTranslation:CGPointZero inView:self];
}
- (void)pinch:(UIPinchGestureRecognizer*)sender {
    [self.superview bringSubviewToFront:self];
    self.transform = CGAffineTransformScale(self.transform, sender.scale, sender.scale);
    sender.scale = 1;
}

-(void)tap:(UITapGestureRecognizer*)sender{
    [self.superview bringSubviewToFront:self];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end
