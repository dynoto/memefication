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

//- (void) getScreenSize;
+ (CGColorRef) getColor:(NSString *)colorName;
+ (void) batchUpdateMemeDataFromJson;
+ (void) clearMemeImageData;
+ (void) saveMemeImage:(NSString*)memeId memeImageName:(NSString *)memeImageName;
+ (void) updateMemeJSON;

+ (NSArray*) getMemeImageList;
+ (NSArray*) getMemeImageList:(NSString*) memeName;
+ (NSArray*) getMemeLiked:(NSString*)memeId;
+ (NSArray*) getMemeLikedList:(NSString*)memeName;
+ (NSArray*) getMemeImage:(NSString*)memeId getIdOnly:(BOOL)getIdOnly;

+ (UIButton*) addRadius:(UIButton *)button color:(CGColorRef)color;

+ (BOOL) likeMeme:(NSString*)memeId;
@end
