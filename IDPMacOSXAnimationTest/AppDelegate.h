//
//  AppDelegate.h
//  IDPMacOSXAnimationTest
//
//  Created by Artem Chabanniy on 2/20/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, strong) IBOutlet NSView   *leftBackgroundView;
@property (nonatomic, strong) IBOutlet NSView   *rightBackgroundView;
@property (nonatomic, strong) IBOutlet NSView   *leftView;
@property (nonatomic, strong) IBOutlet NSView   *rightView;
@property (nonatomic, strong) IBOutlet NSView   *leftView2;
@property (nonatomic, strong) IBOutlet NSView   *rightView2;

@end

