//
//  UIButton+FGMD.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/11.
//

#import "UIButton+FGMD.h"

@implementation UIButton (FGMD)
- (NSString *)elementContent {
    return self.titleLabel.text;
}
@end
