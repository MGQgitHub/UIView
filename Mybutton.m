//
//  Mybutton.m
//  PostCard
//
//  Created by Zyl on 13-11-19.
//  Copyright (c) 2013年 miao. All rights reserved.
//

#import "Mybutton.h"

@implementation Mybutton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 25, 50, 20);
    
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, 25, 15);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
