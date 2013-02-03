//
//  ViewController.m
//  GlossyButtons
//
//  Created by JASON EVERETT on 2/2/13.
//  Copyright (c) 2013 JASON EVERETT. All rights reserved.
//

#import "ViewController.h"
#import "GlossyButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect rect = CGRectMake(86,252,148,44);
    GlossyButton *glossyBtn = [[GlossyButton alloc] initWithFrame:rect withBackgroundColor:[UIColor redColor]];
    [self.view addSubview:glossyBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
