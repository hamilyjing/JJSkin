//
//  ViewController.m
//  JJSkin
//
//  Created by JJ on 6/1/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "ViewController.h"

#import "JJSkin.h"
#import "JJSkin+Test.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *label;

@end

@implementation ViewController

- (IBAction)jjskinTest:(id)sender {
    jjSkinTest();
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [[JJSkinManager sharedSkinManager] updateLabel:_label withID:@"R.testLabel"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
