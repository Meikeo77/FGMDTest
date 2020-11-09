//
//  FGMDStyle.h
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/9.
//

#ifndef FGMDStyle_h
#define FGMDStyle_h

#define UIColorFromRGBA(rgbValue, a) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:a]

#endif /* FGMDStyle_h */
