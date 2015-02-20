//
//  AppDelegate.m
//  IDPMacOSXAnimationTest
//
//  Created by Artem Chabanniy on 2/20/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.leftBackgroundView.layer.backgroundColor = [[NSColor whiteColor] CGColor];
    self.rightBackgroundView.layer.backgroundColor = [[NSColor whiteColor] CGColor];
    
    self.leftView.layer.backgroundColor = [[NSColor redColor] CGColor];
    self.rightView.layer.backgroundColor = [[NSColor blueColor] CGColor];
}

- (IBAction)onStart:(id)sender {
    [self animateLeftView];
    [self animateRightView];
}

- (IBAction)onReset:(id)sender {
    NSRect frame = self.leftView.frame;
    frame.origin.y = 0;
    self.leftView.frame = frame;
    
    frame = self.rightView.frame;
    frame.origin.y = 0;
    self.rightView.frame = frame;
    self.rightView.alphaValue = 1;
}

- (void)animateLeftView {
    NSRect frame = self.leftView.frame;
    frame.origin.y = NSHeight(frame);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.duration = 2;
    animation.fromValue = @(0);
    animation.toValue = @(frame.origin.y);
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation2.duration = 2;
    animation2.fromValue = @(1);
    animation2.toValue = @(0);
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    self.leftView.frame = frame;
    
    [self.leftView.layer addAnimation:animation forKey:nil];
    [self.leftView.layer addAnimation:animation2 forKey:nil];
}

- (void)animateRightView {
    __block NSRect frame = self.rightView.frame;
    frame.origin.y = NSHeight(frame);
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 2;
        context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [self.rightView animator].frame = frame;
        [self.rightView animator].alphaValue = 0;
    } completionHandler:^{
      
    }];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
