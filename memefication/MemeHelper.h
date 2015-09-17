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
- (id) parseResponse:(NSData*)data;

+ (NSDictionary*) getMemeImageList;
+ (NSDictionary*) getMemeImageList:(NSString*)memeName pageUrl:(NSString*)pageUrl;
+ (NSArray*) getMemeLiked:(NSString*)memeId;
+ (NSArray*) getMemeLikedList:(NSString*)memeName;
+ (NSArray*) getMemeImage:(NSString*)memeId getIdOnly:(BOOL)getIdOnly;
+ (NSMutableArray*) getMemeLikedListID;

+ (UIButton*) addRadius:(UIButton *)button color:(CGColorRef)color;

+ (BOOL) likeMeme:(NSString*)memeId dislike:(BOOL)dislike;
@end
