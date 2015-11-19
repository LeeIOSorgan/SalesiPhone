//
//  ZTestMenu.h
//  eSeller4iPad
//
//  Created by ZTaoTech ZG on 8/2/13.
//  Copyright (c) 2013 ZTaoTech. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Jastor.h"

@interface image : Jastor

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* src;

@end



@interface text : Jastor

@property (nonatomic, copy) NSString* data;
@property (nonatomic, copy) NSNumber* size;
@property (nonatomic, copy) NSString* style;

@end


@interface window : Jastor

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSNumber* height;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSNumber* width;

@end


@interface widget : Jastor

@property (nonatomic ) NSString* debug;
@property (nonatomic ) image* image;
@property (nonatomic ) text* text;
@property (nonatomic ) window* window;

@end

@interface ZTest : Jastor

@property (nonatomic ) widget* widget;

@end
