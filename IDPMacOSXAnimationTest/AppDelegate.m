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
    self.leftView2.layer.backgroundColor = [[NSColor blueColor] CGColor];
    self.rightView2.layer.backgroundColor = [[NSColor yellowColor] CGColor];
    
    NSRect frame = self.leftView2.frame;
    frame.origin.y = -NSHeight(frame);
    self.leftView2.frame = frame;
    
    frame = self.rightView2.frame;
    frame.origin.y = -NSHeight(frame);
    self.rightView2.frame = frame;
}

- (IBAction)onStart:(id)sender {
    [self animateLeftView];
    [self animateRightView];
}

- (IBAction)onReset:(id)sender {
    NSRect frame = self.leftView.frame;
    frame.origin.y = 0;
    self.leftView.frame = frame;
    [self.leftView.layer removeAllAnimations];
    
    frame = self.leftView2.frame;
    frame.origin.y = -NSHeight(frame);
    self.leftView2.frame = frame;
    
    frame = self.rightView.frame;
    frame.origin.y = 0;
    self.rightView.frame = frame;
    self.rightView.alphaValue = 1;
    
    frame = self.rightView2.frame;
    frame.origin.y = -NSHeight(frame);
    self.rightView2.frame = frame;
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
    
    frame = self.leftView2.frame;
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation3.duration = 2;
    animation3.fromValue = @(frame.origin.y);
    animation3.toValue = @(0);
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation4.duration = 2;
    animation4.fromValue = @(0);
    animation4.toValue = @(1);
    animation4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    frame.origin.y = 0;
    self.leftView2.frame = frame;
    
    [CATransaction begin];
    [self.leftView.layer addAnimation:animation forKey:nil];
    [self.leftView.layer addAnimation:animation2 forKey:nil];
    [self.leftView2.layer addAnimation:animation3 forKey:nil];
    [self.leftView2.layer addAnimation:animation4 forKey:nil];
    [CATransaction commit];
}

- (void)animateRightView {
    __block NSRect frame = self.rightView2.frame;
    frame.origin.y = 0;
    self.rightView2.alphaValue = 0;
    self.rightView.alphaValue = 1;
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 2;
        context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [self.rightView2 animator].frame = frame;
        [self.rightView animator].alphaValue = 0;
        [self.rightView2 animator].alphaValue = 1;
    } completionHandler:^{
      
    }];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
