//
//  JJTableViewStyle.m
//  JJSkin
//
//  Created by gongjian03 on 6/8/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import "JJTableViewStyle.h"

#import "JJSkinManager.h"

@implementation JJTableViewStyle

#pragma mark - JJSkinStyleDataSource

+ (id)objectFromStyle:(id)style
{
    UITableView *tableView = [[UITableView alloc] init];
    [style updateObject:tableView];
    return tableView;
}

- (void)updateObject:(id)object
{
    [super updateObject:object];
    
    UITableView *tableView = (UITableView *)object;
    
    if (_separatorStyle)
    {
        tableView.separatorStyle = [JJSkinManager getIntegerFromString:_separatorStyle];
    }
    
    if (_separatorColor)
    {
        tableView.separatorColor = _separatorColor;
    }
    
    if (_separatorInset)
    {
        tableView.separatorInset = [JJSkinManager getEdgeInsetsByID:_separatorInset];
    }
}

@end
