//
//  ViewController.m
//  FCPageViewController
//
//  Created by 李晓飞 on 2019/2/24.
//  Copyright © 2019年 xiaofei. All rights reserved.
//

#import "ViewController.h"
#import "FCPageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    FCPageViewController *pageVc = [[FCPageViewController alloc] init];
    [self.navigationController pushViewController:pageVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
