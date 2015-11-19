

#import "ZSlideTableView.h"

@implementation ZSlideTableView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addSwipe];
    }
    return self;
}

-(void)dealloc
{
    _slideDelegate = nil;
    [self removeFromSuperview];
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]){
        [self addSwipe];
    }
    
    return self;
}

- (void)handleSwipe:(UISwipeGestureRecognizer*)gr{
    
    float offset = 0;
    if (gr.direction == UISwipeGestureRecognizerDirectionRight){
        offset = 1;
    }else if (gr.direction == UISwipeGestureRecognizerDirectionLeft){
        offset = -1;
    }
    
    if (_slideDelegate && [_slideDelegate respondsToSelector: @selector(tableViewSlide:offset:)])
    {
        [_slideDelegate tableViewSlide:self offset:offset];
    }
}

- (void)addSwipe{
    
    UISwipeGestureRecognizer *recognizer1;
    
    recognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [recognizer1 setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self addGestureRecognizer:recognizer1];
//    [recognizer1 release];
    
    
    
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self addGestureRecognizer:recognizer];
//    [recognizer release];
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSEnumerator *reverseE = [self.subviews reverseObjectEnumerator];
    UIView *iSubView;
    
    while ((iSubView = [reverseE nextObject])) {
        
        UIView *viewWasHit = [iSubView hitTest:[self convertPoint:point toView:iSubView] withEvent:event];
        if(viewWasHit) {
            return viewWasHit;
        }
        
    }
    
    return [super hitTest:point withEvent:event];
}

/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _touchBeginPoint = [touch locationInView:self];
    
    
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self];
    
    if (abs(currentLocation.x - _touchBeginPoint.x) > 30){
        
        ZLogInfo(@"zzzz table view slide.");
        
        float offset = currentLocation.x - _touchBeginPoint.x;
        
        if (_slideDelegate && [_slideDelegate respondsToSelector: @selector(tableViewSlide:offset:)])
        {
            [_slideDelegate tableViewSlide:self offset:offset];
        }
    }
    [super touchesEnded:touches withEvent:event];
}
 
 */

@end
