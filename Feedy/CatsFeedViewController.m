//
//  FirstViewController.m
//  Feedy
//
//  Created by Javier Rosas on 6/11/15.
//  Copyright (c) 2015 Javier Rosas. All rights reserved.
//

#import "CatsFeedViewController.h"

@interface CatsFeedViewController ()

@property NSSet *feed;

@end

@implementation CatsFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 500;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feed.count;
}

@end
