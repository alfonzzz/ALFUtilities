//
//  NSObject+ALFRuntime.m
//
//  Created by Allon Freedman on 8/12/13.
//  Copyright (c) 2013 Alfonzzz. All rights reserved.
//

#import "NSObject+ALFRuntime.h"
#import <objc/runtime.h>
#import "ALFProperty.h"

@implementation NSObject (ALFRuntime)

- (NSArray *)properties {
    NSMutableArray *propertyArray = [NSMutableArray array];

    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (int i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        ALFProperty *myProperty = [[ALFProperty alloc] initWithName:@(property_getName(property)) clazz:[NSObject propertyClass:property]];
        [propertyArray addObject:myProperty];
    }
    free(properties);
    
    return propertyArray;
}

- (NSArray *)propertyNames {
    NSArray *properties = [self properties];
    NSMutableArray *propertyNames = [NSMutableArray arrayWithCapacity:properties.count];
    
    for (ALFProperty *property in properties) {
        [propertyNames addObject:property.name];
    }
    
    return propertyNames;
}

+ (Class)propertyClass:(objc_property_t)property {
    return NSClassFromString([self propertyClassName:property]);
}

+ (NSString *)propertyClassName:(objc_property_t)property {
    NSString *propertyAttributes = @(property_getAttributes(property));
    NSString *propertyTypeEncoding = [[propertyAttributes componentsSeparatedByString:@","][0] substringFromIndex:1];
    NSString *className = [self stripStringLiteralFromString:propertyTypeEncoding];
    
    return className;
}

+ (NSString *)stripStringLiteralFromString:(NSString *)string {
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"@\"(.*)\"" options:0 error:nil];
    NSRange range = [[regex firstMatchInString:string options:0 range:NSMakeRange(0, string.length)] rangeAtIndex:1];
    if (range.location == NSNotFound) {
        return string;
    }
    
    return [string substringWithRange:range];
}

@end
