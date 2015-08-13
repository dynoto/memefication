//
//  MemeHelper.h
//  memefication
//
//  Created by David Tjokroaminoto on 13/8/15.
//  Copyright (c) 2015 David Tjokroaminoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MemeHelper : NSObject

//- (UIColor*) getIosColor;
//- (void) getScreenSize;
+ (void) batchUpdateMemeDataFromJson;
+ (void) clearMemeImageData;
+ (void) saveMemeImage:(NSString *)memeName memeImageName:(NSString *)memeImageName;
+ (NSArray*) getMemeImageList;
+ (UIButton *) addButtonRadius:(UIButton *)button color:(CGColorRef)color;

@end
