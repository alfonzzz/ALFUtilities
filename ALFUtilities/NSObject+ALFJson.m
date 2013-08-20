//
//  NSObject+ALFJson.m
//
//  Created by Allon Freedman on 8/14/13.
//  Copyright (c) 2013 Alfonzzz. All rights reserved.
//

#import "NSObject+ALFJson.h"
#import "NSObject+ALFDictionariable.h"

@implementation NSObject (ALFJson)

- (instancetype)initFromJson:(NSString *)json
{
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                   options:kNilOptions
                                                                     error:nil];
    return [self initFromDictionary:dictionary];
}

- (NSString *)asJson {
    // Convert object to data
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self asDictionary]
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    
    // Convert Json data to string
    return [[NSString alloc] initWithData:jsonData
                                 encoding:NSUTF8StringEncoding];
}

@end
