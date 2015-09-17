//
//  MemeHelper.m
//  memefication
//
//  Created by David Tjokroaminoto on 13/8/15.
//  Copyright (c) 2015 David Tjokroaminoto. All rights reserved.
//

#import "MemeHelper.h"
#import "AppDelegate.h"
#import "Api.h"

@implementation MemeHelper

- (void)getScreenSize {
    CGRect screenSize = [UIScreen mainScreen].applicationFrame;
}

//- (id) parseResponse:(NSData *) data {
//    
//    NSString *myData = [[NSString alloc] initWithData:data
//                                             encoding:NSUTF8StringEncoding];
//    NSLog(@"JSON data = %@", myData);
//    NSError *error = nil;
//    
//    //parsing the JSON response
//    id jsonObject = [NSJSONSerialization
//                     JSONObjectWithData:data
//                     options:NSJSONReadingAllowFragments
//                     error:&error];
//    if (jsonObject != nil && error == nil){
//        NSLog(@"Successfully deserialized...");
//        
//        return jsonObject;
//    } else {
//        return nil;
//    }
//    
//}


+ (NSArray *)getMemeImage:(NSString*)memeId getIdOnly:(BOOL)getIdOnly {
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
    if (memeId != nil) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(identifier = %@)",memeId];
        [req setPredicate:pred];
    }
    
    return [moc executeFetchRequest:req error:nil];
}

+ (NSDictionary *)getMemeImageList:(NSString*)memeName pageUrl:(NSString*)pageUrl {
    NSURL *url;
    
    if (pageUrl) {
        url = [NSURL URLWithString:pageUrl];
    } else {
        url = [NSURL URLWithString:MEME_LIST];
    }
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    //sets the receiver’s timeout interval, in seconds
    [urlRequest setTimeoutInterval:30.0f];
    //sets the receiver’s HTTP request method
    [urlRequest setHTTPMethod:@"GET"];
    //sets the request body of the receiver to the specified data.
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];

    NSString *stringData = [[NSString alloc] initWithData:responseData
                                             encoding:NSUTF8StringEncoding];
//    NSLog(@"JSON data = %@", stringData);
    
    //parsing the JSON response
    id jsonObject = [NSJSONSerialization
                     JSONObjectWithData:responseData
                     options:NSJSONReadingAllowFragments
                     error:&error];
    if (jsonObject != nil && error == nil){
        return jsonObject;
    } else {
        return nil;
    }
    
//    
//    
//    [NSURLConnection
//     sendAsynchronousRequest:urlRequest
//     queue:queue
//     completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
//         if ([data length] > 0 && error == nil) {
//             dispatch_async(dispatch_get_main_queue(), ^{
//                 NSDictionary *response = [self parseResponse:data];
//                 
//             });
//         }
//         else if ([data length] == 0 && error == nil){
//             NSLog(@"Empty Response, not sure why?");
//         }
//         else if (error != nil){
//             NSLog(@"Not again, what is the error = %@", error);
//         }
//     }];
    
    
    
    
//    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//    
//    // MOC is like getting the database, in this case from AppDelegate
//    NSManagedObjectContext *moc = [delegate managedObjectContext];
//    
//    // Entity description is similar to selecting "table"
//    NSEntityDescription *ed = [NSEntityDescription entityForName:@"MemeImage" inManagedObjectContext:moc];
//    
//    // Create a fetch request, set the entity is like pointing to the database table
//    NSFetchRequest *req = [[NSFetchRequest alloc] init];
//    [req setEntity:ed];
//    
//    // GET ID ONLY USED IN SCENARIOS WHERE YOU WANT TO CHECK IF THE DATA EXISTS
//    // if (getIdOnly) {
//    //     [req setFetchLimit:1];
//    //     [req setIncludesPropertyValues:NO];
//    // }
//    
//    // similar to SQL query "where"
//    if (memeName != nil) {
//        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name CONTAINS[cd] %@)",memeName];
//        [req setPredicate:pred];
//    }
//    
//    return [moc executeFetchRequest:req error:nil];
}




+ (NSDictionary *)getMemeImageList {
    return [self getMemeImageList:nil pageUrl:nil];
}

+ (BOOL)isMemeExist:(NSString*)memeId {
    NSArray *result = [self getMemeImage:memeId getIdOnly:true];
    return [[result firstObject] valueForKey:@"identifier"] != nil;
}

+ (void)saveMemeImage:(NSString*)memeId memeName:(NSString *)memeName memeImageName:(NSString *)memeImageName {
    if ([self isMemeExist:memeId] == NO) {
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        
        // MOC is like getting the database, in this case from AppDelegate
        NSManagedObjectContext *moc = [delegate managedObjectContext];
        
        // Entity description is similar to selecting "table"
        // NSManagedObject is for "saving" file
        NSEntityDescription *ed = [NSEntityDescription entityForName:@"MemeImage" inManagedObjectContext:moc];
        NSManagedObject *mo = [[NSManagedObject alloc] initWithEntity:ed insertIntoManagedObjectContext:moc];
        
        [mo setValue:memeId forKey:@"identifier"];
        [mo setValue:memeName forKey:@"name"];
        [mo setValue:memeImageName forKey:@"image_name"];
        [moc save:nil];
    }
}

+ (void)updateMemeJSON {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"MemeData" ofType:@"json"];
    NSData *jsonFile = [NSData dataWithContentsOfFile:filePath];
//    NSURL *localFileURL = [NSURL fileURLWithPath:@"Supporting Files/MemeData.json"];
//    NSData *jsonFile = [NSData dataWithContentsOfURL:localFileURL];
    NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:jsonFile options:kNilOptions error:nil];
    NSArray *images = [jsonData valueForKey:@"MemeImage"];
    
    for (NSArray *image in images) {
        NSString *memeId = [image valueForKey:@"identifier"];
        NSString *memeName = [image valueForKey:@"name"];
        NSString *memeImageName = [image valueForKey:@"image_name"];
        [self saveMemeImage:memeId memeName:memeName memeImageName:memeImageName];
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

+ (BOOL)likeMeme:(NSString *)memeId dislike:(BOOL)dislike {
    NSArray *result = [self getMemeLiked:memeId];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"MemeFavourite" inManagedObjectContext:moc];
    
    if ([[result firstObject] valueForKey:@"identifier"] == nil && dislike != YES) {
        NSManagedObject *mo = [[NSManagedObject alloc] initWithEntity:ed insertIntoManagedObjectContext:moc];
        
        [mo setValue:memeId forKey:@"identifier"];
        [moc save:nil];
        return true;
    } else if ([[result firstObject] valueForKey:@"identifier"] != nil && dislike == YES){
        NSLog(@"Dislike this");
        [moc deleteObject:[result firstObject]];
        [moc save:nil];
        return true;
    }else {
        return false;
    }
}

+ (NSArray *)getMemeLiked:(NSString *)memeId{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    // MOC is like getting the database, in this case from AppDelegate
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    
    // Entity description is similar to selecting "table"
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"MemeFavourite" inManagedObjectContext:moc];
    
    // Create a fetch request, set the entity is like pointing to the database table
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    [req setEntity:ed];
    
    
    // similar to SQL query "where"
    NSPredicate *pred;
    if (memeId != nil) {
        pred = [NSPredicate predicateWithFormat:@"(identifier = %@)",memeId];
        [req setPredicate:pred];
    }
    
    return [moc executeFetchRequest:req error:nil];
}

+ (NSArray *)getMemeLikedList:(NSString *)memeName{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    
//    GET ALL FAVOURITES FIRST
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"MemeFavourite" inManagedObjectContext:moc];
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    [req setEntity:ed];
    NSError *error;
    NSArray *memeLikedList = [moc executeFetchRequest:req error:&error];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSArray *likedObj in memeLikedList) {
        [tempArray addObject:[[likedObj valueForKey:@"identifier"] stringValue]];
    }
    
//    THEN GET ALL IMAGES FILTER IN THE FAVOURITES
    ed = [NSEntityDescription entityForName:@"MemeImage" inManagedObjectContext:moc];
    [req setEntity:ed];
    NSPredicate *pred;
    if (memeName != nil) {
        NSPredicate *pd1 = [NSPredicate predicateWithFormat:@"(identifier IN %@)", tempArray];
        NSPredicate *pd2 = [NSPredicate predicateWithFormat:@"(name CONTAINS[cd] %@)",memeName];
        
        NSArray *predicateArray = [[NSArray alloc] initWithObjects:pd1,pd2, nil];
        pred = [NSCompoundPredicate andPredicateWithSubpredicates:predicateArray];
        [req setPredicate:pred];
    } else {
        pred = [NSPredicate predicateWithFormat:@"(identifier IN %@)", tempArray];
        [req setPredicate:pred];
    }
    
    return [moc executeFetchRequest:req error:nil];
}

+ (NSMutableArray*) getMemeLikedListID {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    
    //    GET ALL FAVOURITES FIRST
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"MemeFavourite" inManagedObjectContext:moc];
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    [req setEntity:ed];
    NSError *error;
    NSArray *memeLikedList = [moc executeFetchRequest:req error:&error];
    return [memeLikedList valueForKey:@"identifier"];
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
