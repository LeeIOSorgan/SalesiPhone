

#import <UIKit/UIKit.h>

@class ZSlideTableView;


@protocol ZSlideTableViewDelegate <NSObject>

- (void)tableViewSlide:(ZSlideTableView *)tableView offset:(float)offset;

@end


@interface ZSlideTableView : UITableView{
    
    CGPoint                     _touchBeginPoint;
}

@property (nonatomic, unsafe_unretained) id<ZSlideTableViewDelegate> slideDelegate;

@end


