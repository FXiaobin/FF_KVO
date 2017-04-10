//
//  ViewController.m
//  KVO
//
//  Created by fanxiaobin on 2017/4/10.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+KVO.h"

@interface Message : NSObject

@property (nonatomic, copy) NSString *text;

@end

@implementation Message

@end

@interface ViewController ()


@property (nonatomic, weak) IBOutlet UITextField *textfield;
@property (nonatomic, weak) IBOutlet UIButton *button;

@property (nonatomic, strong) Message *message;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the
    
    
    self.message = [[Message alloc] init];
    [self.message PG_addObserver:self forKey:@"text"
                       withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
                           NSLog(@"%@.%@ is now: %@", observedObject, observedKey, newValue);
                           dispatch_async(dispatch_get_main_queue(), ^{
                               self.textfield.text = newValue;
                           });
                           
                       }];
    
    [self changeMessage:nil];
}


- (IBAction)changeMessage:(id)sender
{
    NSArray *msgs = @[@"Hello World!", @"Objective C", @"Swift", @"Peng Gu", @"peng.gu@me.com", @"www.gupeng.me", @"glowing.com"];
    NSUInteger index = arc4random_uniform((u_int32_t)msgs.count);
    self.message.text = msgs[index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
