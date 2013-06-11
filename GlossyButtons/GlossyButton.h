//
//  GlossyButton.h
//  GlossyButtons
//
//  Created by JASON EVERETT on 2/2/13.
//  Copyright (c) 2013 JASON EVERETT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlossyButton : UIButton
@property(strong, nonatomic)UIColor *myColor;
- (id)initWithFrame:(CGRect)frame withBackgroundColor:(UIColor*)backgroundColor;
@end
