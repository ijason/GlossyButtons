//
//  GlossyButton.m
//  GlossyButtons
//
//  Created by JASON EVERETT on 2/2/13.
//  Copyright (c) 2013 JASON EVERETT. All rights reserved.
//

#import "GlossyButton.h"
#import <QuartzCore/QuartzCore.h>

@interface GlossyButton()
-(void)wasPressed;
-(void)endedPress;
- (void)makeButtonShiny:(GlossyButton*)button withBackgroundColor:(UIColor*)backgroundColor;
@end

@implementation GlossyButton

- (id)initWithFrame:(CGRect)frame withBackgroundColor:(UIColor*)backgroundColor
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //save our color so we can alter it upon a touch event
        self.myColor = backgroundColor;
        [self makeButtonShiny:self withBackgroundColor:backgroundColor];
        [self addTarget:self action:@selector(wasPressed) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(endedPress) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}

- (void)makeButtonShiny:(GlossyButton*)button withBackgroundColor:(UIColor*)backgroundColor
{
    // Get the button layer and give it rounded corners with a semi-transparant button
    CALayer *layer = button.layer;
    layer.cornerRadius = 8.0f;
    layer.masksToBounds = YES;
    layer.borderWidth = 2.0f;
    layer.borderColor = [UIColor colorWithWhite:0.4f alpha:0.2f].CGColor;
    
    // Create a shiny layer that goes on top of the button
    CAGradientLayer *shineLayer = [CAGradientLayer layer];
    shineLayer.frame = button.layer.bounds;
    // Set the gradient colors
    shineLayer.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         nil];
    // Set the relative positions of the gradien stops
    shineLayer.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.0f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.8f],
                            [NSNumber numberWithFloat:1.0f],
                            nil];
    
    // Add the layer to the button
    [button.layer addSublayer:shineLayer];
    
    [button setBackgroundColor:backgroundColor];
}

//When button is touched, grab our existing color and make it 20% darker (or lighter if its black)
//We will return it to its original state when the touch is lifted and touchesEnded:withEvent: is called
-(void)wasPressed
{
    UIColor *newColor;
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0, white = 0.0;
    
    //Check if we're working with atleast iOS 5.0
    if([self.myColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self.myColor getRed:&red green:&green blue:&blue alpha:&alpha];
        [self.myColor getWhite:&white alpha:&alpha];
        
        //test if we're working with a grayscale, black or RGB color
        if(!(red + green + blue) && white){
            //grayscale
            newColor = [UIColor colorWithWhite:white - 0.2 alpha:alpha];
        } else if(!(red + green + blue) && !white) {
            //black
            newColor = [UIColor colorWithWhite:white + 0.2 alpha:alpha];
        } else{
            //RGB
            newColor = [UIColor colorWithRed:red - 0.2 green:green - 0.2 blue:blue - 0.2 alpha:alpha];
        }
    } else if(CGColorGetNumberOfComponents(self.myColor.CGColor) == 4) {
        //for earlier than ios 5
        const CGFloat *components = CGColorGetComponents(self.myColor.CGColor);
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
        
        newColor = [UIColor colorWithRed:red - 0.2 green:green - 0.2 blue:blue - 0.2 alpha:alpha];
    } else if(CGColorGetNumberOfComponents(self.myColor.CGColor) == 2){
        //if we have a non-RGB color
        CGFloat hue;
        CGFloat saturation;
        CGFloat brightness;
        [self.myColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
        
        newColor = [UIColor colorWithHue:hue - 0.2 saturation:saturation - 0.2 brightness:brightness - 0.2 alpha:alpha];
    }
    
    self.backgroundColor = newColor;
    
}

-(void)endedPress
{
    //Reset our button to its original color
    self.backgroundColor = self.myColor;
}
@end
