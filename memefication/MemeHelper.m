//
//  MemeHelper.m
//  memefication
//
//  Created by David Tjokroaminoto on 13/8/15.
//  Copyright (c) 2015 David Tjokroaminoto. All rights reserved.
//

#import "MemeHelper.h"
#import "AppDelegate.h"

@implementation MemeHelper

- (void)getScreenSize {
    CGRect screenSize = [UIScreen mainScreen].applicationFrame;
}

+ (NSArray *)getMemeImageList:(NSString *)memeName getIdOnly:(BOOL)getIdOnly {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    // MOC is like getting the database, in this case from AppDelegate
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    
    // Entity description is similar to selecting "table"
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"MemeImage" inManagedObjectContext:moc];
    
    // Create a fetch request, set the entity is like pointing to the database table
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    [req setEntity:ed];
    
    // GET ID ONLY USED IN SCENARIOS WHERE YOU WANT TO CHECK IF THE DATA EXISTS
    if (getIdOnly) {
        [req setFetchLimit:1];
        [req setIncludesPropertyValues:NO];
    }
    
    // similar to SQL query "where"
    if (memeName != nil) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)",memeName];
        [req setPredicate:pred];
    }
    
    return [moc executeFetchRequest:req error:nil];
}

+ (NSArray *)getMemeImageList {
    return [self getMemeImageList:nil getIdOnly:false];
}

+ (BOOL)isMemeExist:(NSString *)memeName {
    NSArray *result = [self getMemeImageList:memeName getIdOnly:true];
    return [[result firstObject] valueForKey:@"name"] != nil;
}

+ (void)saveMemeImage:(NSString *)memeName memeImageName:(NSString *)memeImageName {
    if ([self isMemeExist:memeName] == NO) {
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        
        // MOC is like getting the database, in this case from AppDelegate
        NSManagedObjectContext *moc = [delegate managedObjectContext];
        
        // Entity description is similar to selecting "table"
        // NSManagedObject is for "saving" file
        NSEntityDescription *ed = [NSEntityDescription entityForName:@"MemeImage" inManagedObjectContext:moc];
        NSManagedObject *mo = [[NSManagedObject alloc] initWithEntity:ed insertIntoManagedObjectContext:moc];
        
        [mo setValue:memeName forKey:@"name"];
        [mo setValue:memeImageName forKey:@"image_name"];
        [moc save:nil];
    }
}


+ (void)clearMemeImageData {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    
    NSArray *imageList = [self getMemeImageList];
    
    for (NSManagedObject *obj in imageList) {
        [moc deleteObject:obj];
    }
    [moc save:nil];
    
}

+ (void) batchUpdateMemeDataFromJson {
    
}

+ (UIButton *) addRadius:(UIButton *)button color:(CGColorRef)color {
    if (color == nil) {
        color = [self getColor:@"blue"];
    }
    
    button.layer.cornerRadius = 6.25;
    button.layer.borderWidth  = 1.0f;
    button.layer.borderColor  = color;
    return button;
}

+ (CGColorRef) getColor:(NSString *)color {
    if ([color  isEqualToString:@"red"]) {
        return [[UIColor colorWithRed:255/255.0 green:71/255.0 blue:19/255.0 alpha:1.0] CGColor];
    }else if ([color isEqualToString:@"blue"]){
        return [[UIColor colorWithRed:19/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] CGColor];
    }else {
        return nil;
    }
}



@end
