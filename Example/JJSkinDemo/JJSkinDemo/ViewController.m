//
//  ViewController.m
//  JJSkinDemo
//
//  Created by JJ on 3/4/16.
//  Copyright © 2016 JJ. All rights reserved.
//

#import "ViewController.h"

#import "JJSkin.h"
#import "JJSkin+Test.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)jjskinTest:(id)sender {
    jjSkinTest();
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [[JJSkinManager sharedSkinManager] updateLabel:_label withID:@"R.testLabel"];
}

@end
