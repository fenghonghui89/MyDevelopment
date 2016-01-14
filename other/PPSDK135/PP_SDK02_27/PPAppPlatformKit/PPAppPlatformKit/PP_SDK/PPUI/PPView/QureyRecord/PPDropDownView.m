//
//  PPDropDownView.m
//  ListViewTest
//
//  Created by Seven on 13-10-17.
//  Copyright (c) 2013年 1. All rights reserved.
//

#import "PPDropDownView.h"
#import "PPUIKit.h"


@implementation PPDropDownView



- (id)init{
    self = [super init];
    if (self) {
        _countOfItems = 0;
        _items = [[NSMutableArray alloc] init];
        _isOpen = NO;
        
        [self setBackgroundColor:[UIColor whiteColor]];
		[self setMultipleTouchEnabled:YES];
		[self setUserInteractionEnabled:YES];
        
        [self setClipsToBounds:YES];
    }

    return self;
}

- (NSInteger)addItemWithButtonTitle:(NSString *)title itemFrame:(CGRect)frame{
    
    PPListItemView *item = [[PPListItemView alloc] initWithButtonTitle:title itemFrame:frame];
    [item setDelegate:self];
	[self.items addObject:item];
	self.countOfItems += 1;
    [item setItemIndex:[_items indexOfObject:item]];
    
    [self addSubview:item];
    [item release];
	return _countOfItems - 1;
}


- (void)listItemView:(PPListItemView *)view selectedIndex:(NSInteger)index withInfo:(NSDictionary *)info{
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(dropDownView: selectedIndex: withInfo:)]) {
            [self.delegate dropDownView:self selectedIndex:index withInfo:info];
        }
        else{
            NSLog(@"指定的方法dropDownView: selectedIndex: withInfo:未实现");
        }
    }
    else{
        NSLog(@"未实现delegate");
    }
}

- (int)closeView{
//    NSLog(@"item个数：%d",[self.items count]);
    if (_isOpen) {
        [self setFrame:CGRectMake(0, self.frame.origin.y, self.frame.size.width, 0)];
        [self setCountOfItems:0];
        [self setIsOpen:NO];
        [self setClipsToBounds:YES];
    }
    return _selectedIndex;
}

- (void)openView{
    if (!_isOpen) {
        [self setFrame:CGRectMake(0, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
        [self setIsOpen:YES];
    }
}

- (void)selectItem:(int)index{
    if (index >= 0 && index < [_items count]) {
        _selectedIndex = index;
        [[_items objectAtIndex:index] setSelectedState];
        _selectedItem = [[_items objectAtIndex:index] retain];
    }
}

-(void)dealloc{
    [_items release];
    _items = nil;
    
    [_selectedItem release];
    _selectedItem = nil;
    [super dealloc];
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
