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
    self.leftAnimationDuratiion = 1;
    [self.leftComboBox selectItemAtIndex:3];

    self.rightAnimationDuratiion = 1;
    [self.rightComboBox selectItemAtIndex:3];

    
    // Insert code here to initialize your application
    self.leftBackgroundView.layer.backgroundColor = [[NSColor whiteColor] CGColor];
    self.rightBackgroundView.layer.backgroundColor = [[NSColor whiteColor] CGColor];
    
    NSRect frame = self.leftView2.frame;
    frame.origin.y = -NSHeight(frame);
    self.leftView2.frame = frame;
    
    frame = self.rightView2.frame;
    frame.origin.y = -NSHeight(frame);
    self.rightView2.frame = frame;
}

- (IBAction)onStartLeft:(id)sender {
    [self animateLeftView];
}

- (IBAction)onStartRight:(id)sender {
    [self animateRightView];
}

- (IBAction)onStart:(id)sender {
    [self animateLeftView];
    [self animateRightView];
}

- (void)reset {
    [self resetLeft];
    [self resetRight];
}

- (NSString *)timingFunctionForInsex:(NSInteger)index {
    switch (index) {
        case 0:
            return kCAMediaTimingFunctionLinear;
            break;
        case 1:
            return kCAMediaTimingFunctionEaseIn;
            break;
        case 2:
            return kCAMediaTimingFunctionEaseOut;
            break;
        case 3:
            return kCAMediaTimingFunctionEaseInEaseOut;
            break;
        default:
            break;
    }
    return kCAMediaTimingFunctionLinear;
}

- (void)resetLeft {
    [self.leftView.layer removeAllAnimations];
}

- (void)resetRight {
    NSRect frame = self.rightView2.frame;
    self.rightView2.frame = frame;
    frame.origin.y = - NSHeight(frame);
    self.rightView2.frame = frame;
    self.rightView.alphaValue = 1;
    self.rightView2.alphaValue = 0;
}

- (void)animateLeftView {
    [self resetLeft];
    CATransition *transition = [CATransition animation];
    transition.duration = self.leftAnimationDuratiion;
    transition.subtype = kCATransitionFromBottom;
    transition.type = kCATransitionMoveIn;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:[self timingFunctionForInsex:[self.leftComboBox indexOfSelectedItem]]];
    
    [self.leftView.layer addAnimation:transition forKey:nil];
}

- (void)animateRightView {
    [self resetRight];
    NSRect frame = self.rightView2.frame;
    frame.origin.y = 0;
    self.rightView2.alphaValue = 0;
    self.rightView.alphaValue = 1;
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = self.rightAnimationDuratiion;
        context.timingFunction = [CAMediaTimingFunction functionWithName:[self timingFunctionForInsex:[self.rightComboBox indexOfSelectedItem]]];
        [self.rightView2 animator].frame = frame;
        [self.rightView animator].alphaValue = 0;
        [self.rightView2 animator].alphaValue = 1;
    } completionHandler:^{
        [self resetRight];
    }];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
